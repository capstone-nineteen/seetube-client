//
//  Errors.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation

enum PhotoAlbumError: Error {
    case photoLibraryAccessNotAuthorized
    case saveFailed
    case invalidURL
}

enum DownloadError: Error {
    case invalidURL
    case noFileURL
}
