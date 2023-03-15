//
//  PhotoAlbumRepository.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation
import RxSwift

protocol PhotoAlbumRepository {
    func saveVideo(at fileURL: URL) -> Completable
}
