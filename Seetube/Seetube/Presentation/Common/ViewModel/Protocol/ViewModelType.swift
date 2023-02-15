//
//  ViewModelType.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
