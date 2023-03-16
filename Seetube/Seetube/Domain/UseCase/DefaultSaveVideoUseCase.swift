//
//  DefaultSaveVideoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation
import RxSwift

class DefaultSaveVideoUseCase: SaveVideoUseCase {
    private let repository: PhotoAlbumRepository
    
    init(repository: PhotoAlbumRepository) {
        self.repository = repository
    }
    
    func execute(at fileURL: URL) -> Completable {
        return self.repository.saveVideo(at: fileURL)
    }
}
