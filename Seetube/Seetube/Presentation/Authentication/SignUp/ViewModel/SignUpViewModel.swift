//
//  SignUpViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation

class SignUpViewModel: ViewModelType {
    private var userType: UserType
    
    init(userType: UserType) {
        self.userType = userType
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension SignUpViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
