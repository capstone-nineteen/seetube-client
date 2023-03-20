//
//  Errors.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation

enum NetworkServiceError: Error {
    case invalidResponse
}

enum PhotoAlbumError: Error {
    case photoLibraryAccessNotAuthorized
    case saveFailed
    case invalidURL
}

enum DownloadError: Error {
    case invalidURL
    case noFileURL
}

enum OptionalError: Error {
    case nilSelf
}
