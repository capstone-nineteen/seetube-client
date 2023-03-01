//
//  SignInViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/26.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel: ViewModelType {
    private let userType: UserType
    private let signInUseCase: SignInUseCase
    
    init(
        userType: UserType,
        signInUseCase: SignInUseCase
    ) {
        self.userType = userType
        self.signInUseCase = signInUseCase
    }
    
    func transform(input: Input) -> Output {
        let shouldMoveToSignUp = input.signUpButtonTouched
            .map { [weak self] _ in
                return self?.userType
            }
            .compactMap { $0 }
        
        let emailAndPassword = Driver
            .combineLatest(
                input.email,
                input.password
            ) { (email: $0, password: $1)}
        
        let signInResult = input.signInButtonTouched
            .withLatestFrom(emailAndPassword) { $1 }
            .flatMap { [weak self] (email: String, password: String) -> Driver<SignInResult?> in
                guard let self = self else { return .just(nil) }
                return self.signInUseCase
                    .execute(userType: self.userType,
                             email: email,
                             password: password)
                    .asDriver(onErrorJustReturn: nil)
            }
        // TODO: 토큰 키체인 저장
        
        let signInSucceed = signInResult
            .compactMap { $0 }
            .map { [weak self] _ in self?.userType }
            .compactMap { $0 }
        
        let signInFailed = signInResult
            .filter { $0 == nil }
            .mapToVoid()
        
        return Output(shouldMoveToSignUp: shouldMoveToSignUp,
                      signInSucceed: signInSucceed,
                      signInFailed: signInFailed)
    }
}

extension SignInViewModel {
    struct Input {
        let signUpButtonTouched: Driver<Void>
        let email: Driver<String>
        let password: Driver<String>
        let signInButtonTouched: Driver<Void>
    }
    
    struct Output {
        let shouldMoveToSignUp: Driver<UserType>
        let signInSucceed: Driver<UserType>
        let signInFailed: Driver<Void>
    }
}
