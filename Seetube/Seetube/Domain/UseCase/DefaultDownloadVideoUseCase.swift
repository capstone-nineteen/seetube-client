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
    func execute(url: String) -> Observable<URL?> {
        guard let url = URL(string: url) else { return .just(nil) }

        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(url.lastPathComponent)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        return Observable<URL?>.create { observable in
            AF.download(url, to: destination)
                .response { response in
                    observable.onNext(response.fileURL)
                    observable.onCompleted()
                }
            
            return Disposables.create()
        }
    }
}