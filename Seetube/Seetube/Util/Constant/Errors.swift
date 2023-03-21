//
//  Errors.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation

enum NetworkServiceError: Error {
    case invalidResponse
    case requestFailed
}

enum PhotoAlbumError: Error {
    case photoLibraryAccessNotAuthorized
    case saveFailed
    case invalidURL
    case unknown
}

enum DownloadError: Error {
    case invalidURL
    case noFileURL
    case unknown
}

enum OptionalError: Error {
    case nilSelf
}
