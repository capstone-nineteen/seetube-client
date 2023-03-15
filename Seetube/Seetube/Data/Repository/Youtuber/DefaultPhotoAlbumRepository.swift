//
//  DefaultPhotoAlbumRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation
import RxSwift
import Photos

class DefaultPhotoAlbumRepository: PhotoAlbumRepository {
    func saveVideo(at fileURL: URL) -> Completable {
        return Completable.create { completable in
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
                    }, completionHandler: { (success, error) in
                        if success {
                            completable(.completed)
                        } else {
                            completable(.error(PhotoAlbumError.saveFailed))
                        }
                    })
                default:
                    completable(.error(PhotoAlbumError.photoLibraryAccessNotAuthorized))
                }
            }
            
            return Disposables.create()
        }
    }
}
