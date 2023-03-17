//
//  DownloadVideoUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/15.
//

import Foundation
import RxSwift

protocol DownloadVideoUseCase {
    func execute(url: String) -> Observable<URL>
}
