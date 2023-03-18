//
//  ShortsResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/13.
//

import Foundation
import RxCocoa
import RxSwift

class ShortsResultViewModel: ViewModelType {
    private let videoId: Int
    private let fetchShortsResultUseCase: FetchShortsResultUseCase
    private let downloadVideoUseCase: DownloadVideoUseCase
    private let saveVideoUseCase: SaveVideoUseCase
    
    init(
        videoId: Int,
        fetchShortsResultUseCase: FetchShortsResultUseCase,
        downloadVideoUseCase: DownloadVideoUseCase,
        saveVideoUseCase: SaveVideoUseCase
    ) {
        self.videoId = videoId
        self.fetchShortsResultUseCase = fetchShortsResultUseCase
        self.downloadVideoUseCase = downloadVideoUseCase
        self.saveVideoUseCase = saveVideoUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<ShortsResult?> in
                // 더미 데이터
                let scene = ShortsScene(thumbnailURL: "https://avatars.githubusercontent.com/u/70833900?s=80&u=7b4aff238820c6e6d3968848b78e8d8bf1b1507e&v=4", videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", startTime: 0, endTime: 3, concentrationPercentage: 20, emotionType: .angry, emotionPerentage: 24)
                let temp = ShortsResult(scenes: [scene, scene, scene, scene, scene, scene, scene])
                return .just(temp)
                
                guard let self = self else { return .just(nil) }
                return self.fetchShortsResultUseCase
                    .execute(videoId: self.videoId)
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let isSelectionMode = Driver
            .merge(
                input.selectedButtonTouched
                    .map { _ in true },
                input.saveButtonTouched
                    .map { _ in false }
            )
            .startWith(false)
        
        let playingIndex = input.itemSelected
            .withLatestFrom(isSelectionMode) {
                (itemSelected: $0, isSelectionMode: $1)
            }
            .filter { !$0.1 }
            .scan(nil) { previous, element -> IndexPath? in
                let current = element.itemSelected
                return (previous == current) ? nil : current
            }
            .startWith(nil)
        
        let shorts = Driver
            .combineLatest(
                result.map { $0.scenes },
                isSelectionMode,
                playingIndex
            ) { ($0, $1, $2) }
            .map { (scenes, isSelectionMode, playingIndex) in
                scenes
                    .enumerated()
                    .map { (index, scene) in
                        ShortsItemViewModel(with: scene,
                                            shouldDisplayCheckIcon: isSelectionMode,
                                            isPlaying: index == playingIndex?.row)
                    }
            }
        
        let shouldPlay = playingIndex
            .compactMap { $0 }
            .withLatestFrom(
                result.map { $0.scenes }
            ) { (indexPath, scenes) in
                let url = URL(string: scenes[indexPath.row].videoURL)
                return (url: url, indexPath: indexPath)
            }
        
        let shouldPause = playingIndex
            .filter { $0 == nil }
            .withLatestFrom(shouldPlay) { $1.indexPath }
        
        let selectedOrDeselected = Driver
            .merge(
                input.itemSelected
                    .map { (isSelected: true, value: $0) },
                input.itemDeselected
                    .map { (isSelected: false, value: $0) }
            )
        
        let selectedItems = Driver
            .combineLatest(
                selectedOrDeselected,
                isSelectionMode
            ) { (item: $0, isSelectionMode: $1) }
            .scan([IndexPath]()) { acc, element in
                guard element.isSelectionMode else { return [] }
                
                let isSelected = element.item.isSelected
                let value = element.item.value
    
                if isSelected {
                    return acc + [value]
                } else {
                    return acc.filter { $0 != value }
                }
            }
            .startWith([])
            
        let downloadURLList = selectedItems
            .withLatestFrom(
                result.map { $0.scenes }
            ) { selectedItems, scenes in
                selectedItems.map { scenes[$0.row].videoURL }
            }
        
        let videoFileURLs = input.saveButtonTouched
            .withLatestFrom(
                downloadURLList.filter { !$0.isEmpty }
            ) { $1 }
            .asObservable()
            .flatMap { [weak self] urls -> Observable<[URL]> in
                guard let self = self else {
                    return .error(NSError(domain: "nil self", code: -1))
                }
                
                let downloads = urls.map { self.downloadVideoUseCase.execute(url: $0) }
                return Observable.combineLatest(downloads)
            }
        
        let numberOfSelectedShorts = selectedItems
            .map { $0.count }
        
        let videoSaveResult = videoFileURLs
            .flatMap { [weak self] fileURLs -> Observable<[Void]> in
                guard let self = self else {
                    return .error(NSError(domain: "nil self", code: -1))
                }
                let saves = fileURLs.map {
                    self.saveVideoUseCase
                        .execute(at: $0)
                        .andThen(Observable.just(()))
                }
                return Observable.combineLatest(saves)
            }
            .share()
        
        let saveSuccess = videoSaveResult
            .map { _ in true }
            .catch { error in
                if let photoAlbumError = error as? PhotoAlbumError,
                   photoAlbumError == .photoLibraryAccessNotAuthorized {
                    return .never()
                } else {
                    throw error
                }
            }
            .asDriver(onErrorJustReturn: false)
        
        let shouldRequestAuthorization = videoSaveResult
            .catch { error in
                if let photoAlbumError = error as? PhotoAlbumError,
                   photoAlbumError == .photoLibraryAccessNotAuthorized {
                    throw error
                } else {
                    return .never()
                }
            }
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
        
        return Output(shorts: shorts,
                      shouldPlay: shouldPlay,
                      shouldPause: shouldPause, numberOfSelectedShorts: numberOfSelectedShorts,
                      saveResult: saveSuccess,
                      shouldRequestAuthorization: shouldRequestAuthorization)
    }
}

extension ShortsResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let itemSelected: Driver<IndexPath>
        let itemDeselected: Driver<IndexPath>
        let selectedButtonTouched: Driver<Void>
        let saveButtonTouched: Driver<Void>
    }
    
    struct Output {
        let shorts: Driver<[ShortsItemViewModel]>
        let shouldPlay: Driver<(url: URL?, indexPath: IndexPath)>
        let shouldPause: Driver<IndexPath>
        let numberOfSelectedShorts: Driver<Int>
        let saveResult: Driver<Bool>
        let shouldRequestAuthorization: Driver<Void>
    }
}
