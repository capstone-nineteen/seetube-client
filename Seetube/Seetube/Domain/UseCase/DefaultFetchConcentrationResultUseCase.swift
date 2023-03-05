//
//  DefaultFetchConcentrationResultUseCase.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation
import RxSwift

class DefaultFetchConcentrationResultUseCase: FetchConcentrationResultUseCase {
    private let repository: ConcentrationResultRepository
    
    init(repository: ConcentrationResultRepository) {
        self.repository = repository
    }
    
    func execute(videoId: Int) -> Observable<ConcentrationResult?> {
        return self.repository.getConcentrationResult()
    }
}
