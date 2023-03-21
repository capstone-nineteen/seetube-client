//
//  HighlightResultViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/12.
//

import Foundation
import RxCocoa
import RxSwift

class HighlightResultViewModel: ViewModelType {
    private let videoId: Int
    private let fetchHighlightResultUseCase: FetchHighlightResultUseCase
    private let downloadVideoUseCase: DownloadVideoUseCase
    private let saveVideoUseCase: SaveVideoUseCase
    
    init(
        videoId: Int,
        fetchHighlightResultUseCase: FetchHighlightResultUseCase,
        downloadVideoUseCase: DownloadVideoUseCase,
        saveVideoUseCase: SaveVideoUseCase
    ) {
        self.videoId = videoId
        self.fetchHighlightResultUseCase = fetchHighlightResultUseCase
        self.downloadVideoUseCase = downloadVideoUseCase
        self.saveVideoUseCase = saveVideoUseCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.viewWillAppear
            .flatMap { [weak self] _ -> Driver<HighlightResult?> in
                // 더미 데이터
                let scenes = (0..<5).map {
                    HighlightScene(thumbnailImageURL: "https://avatars.githubusercontent.com/u/70833900?s=80&u=7b4aff238820c6e6d3968848b78e8d8bf1b1507e&v=4", startTimeInOriginalVideo: 12+$0*5, endTimeInOriginalVideo: 12+($0+1)*5, startTimeInHighlight: $0*5, endTimeInHighlight: ($0+1)*5, totalNumberOfReviewers: 140, numberOfReviewersConcentrated: 78, numberOfReviewersFelt: 100, emotionType: .angry)
                }
                let temp = HighlightResult(highlightVideoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                               scenes: scenes)
                return .just(temp)
                
                guard let self = self else { return .just(nil) }
                return self.fetchHighlightResultUseCase
                    .execute(videoId: self.videoId)
                    .map { $0 as HighlightResult? }
                    .asDriver(onErrorJustReturn: nil)
            }
            .compactMap { $0 }
        
        let videoUrl = result
            .map { $0.highlightVideoURL }
        
        let scenes = result
            .map { $0.scenes }
            .map { $0.map { SceneLargeItemViewModel(with: $0) } }
        
        let playingInterval = input.itemSelected
            .withLatestFrom(result) { $1.scenes[$0.row] }
            .map { (start: $0.startTimeInHighlight, end: $0.endTimeInHighlight) }
        
        let videoFileURL = input.saveButtonTouched
            .asObservable()
            .withLatestFrom(videoUrl) { $1 }
            .flatMap { [weak self] url -> Observable<URL> in
                guard let self = self else {
                    return .error(OptionalError.nilSelf)
                }
                return self.downloadVideoUseCase
                    .execute(url: url)
                    .asObservable()
            }
        
        let videoSaveResult = videoFileURL
            .flatMap { [weak self] fileURL -> Observable<Void> in
                guard let self = self else {
                    return .error(OptionalError.nilSelf)
                }
                return self.saveVideoUseCase
                    .execute(at: fileURL)
                    .andThen(Observable.just(()))
            }
            .share()

        let saveSuccess = videoSaveResult
            .map { _ in true }
            .catch { error in
                if let photoAlbumError = error as? PhotoAlbumError,
                   photoAlbumError == .photoLibraryAccessNotAuthorized {
                    return .never()
                } else {
                    // TODO: throw 제거
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
            .asDriver(onErrorJustReturn: ())
        
        return Output(videoUrl: videoUrl,
                      scenes: scenes,
                      playingInterval: playingInterval,
                      videoSaveResult: saveSuccess,
                      shouldRequestAuthorization: shouldRequestAuthorization)
    }
}

extension HighlightResultViewModel {
    struct Input {
        let viewWillAppear: Driver<Bool>
        let itemSelected: Driver<IndexPath>
        let saveButtonTouched: Driver<Void>
    }
    
    struct Output {
        let videoUrl: Driver<String>
        let scenes: Driver<[SceneLargeItemViewModel]>
        let playingInterval: Driver<(start: Int, end: Int)>
        let videoSaveResult: Driver<Bool>
        let shouldRequestAuthorization: Driver<Void>
    }
}
