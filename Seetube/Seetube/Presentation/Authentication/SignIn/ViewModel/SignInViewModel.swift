//
//  SignInViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/26.
//

import Foundation

class SignInViewModel: ViewModelType {
    private let userType: UserType
    
    init(userType: UserType) {
        self.userType = userType
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

extension SignInViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
}
