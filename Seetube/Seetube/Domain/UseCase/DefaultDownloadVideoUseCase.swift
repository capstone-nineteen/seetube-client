//
//  DefaultDownloadVideoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift
import UIKit

class DefaultDownloadVideoUseCase: DownloadVideoUseCase {
    func execute(url: String) -> Single<URL> {
        guard let url = URL(string: url) else { return .error(DownloadError.invalidURL) }

        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        return Single<URL>.create { single in
            AF.download(url, to: destination)
                .response { response in
                    if let fileURL = response.fileURL {
                        single(.success(fileURL))
                    } else {
                        single(.failure(DownloadError.noFileURL))
                    }
                }
            
            return Disposables.create()
        }
    }
}
