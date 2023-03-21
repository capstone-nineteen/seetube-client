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
            .withLatestFrom(videoUrl) { $1 }
            .flatMap { [weak self] url -> Driver<Result<URL, DownloadError>> in
                guard let self = self else { return .just(.failure(.unknown)) }
                return self.downloadVideoUseCase
                    .execute(url: url)
                    .map { .success($0) }
                    .asDriver { error in
                        guard let downloadError = error as? DownloadError else {
                            return .just(.failure(.unknown))
                        }
                        return .just(.failure(downloadError))
                    }
            }
        
        let videoSaveResult = videoFileURL
            .compactMap { videoFileURL -> URL? in
                if case let .success(fileURL) = videoFileURL {
                    return fileURL
                } else {
                    return nil
                }
            }
            .flatMap { [weak self] fileURL -> Driver<Result<Void, PhotoAlbumError>> in
                guard let self = self else { return .just(.failure(.unknown)) }
                return self.saveVideoUseCase
                    .execute(at: fileURL)
                    .andThen(Observable.just(.success(Void())))
                    .asDriver { error in
                        guard let photoAlbumError = error as? PhotoAlbumError else {
                            return .just(.failure(.unknown))
                        }
                        return .just(.failure(photoAlbumError))
                    }
            }

        let saveSuccess = videoSaveResult
            .compactMap { result -> Bool? in
                switch result {
                case .success:
                    return true
                case .failure(let error):
                    if error == .photoLibraryAccessNotAuthorized {
                        return nil
                    } else {
                        return false
                    }
                }
            }

        let shouldRequestAuthorization = videoSaveResult
            .compactMap { result -> Void? in
                if case let .failure(error) = result,
                   error == .photoLibraryAccessNotAuthorized {
                    return ()
                } else {
                    return nil
                }
            }
        
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
