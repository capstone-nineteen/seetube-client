//
//  SignUpViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/28.
//

import Foundation
import RxCocoa
import RxSwift

class SignUpViewModel: ViewModelType {
    private var userType: UserType
    private let requestVerificationCodeUseCase: RequestVerificationCodeUseCase
    private let signUpUseCase: SignUpUseCase
    private let validateUseCase: ValidateSignUpInfoUseCase
    
    init(
         userType: UserType,
         requestVerificationCodeUseCase: RequestVerificationCodeUseCase,
         signUpUseCase: SignUpUseCase,
         validateUseCase: ValidateSignUpInfoUseCase
    ) {
        self.userType = userType
        self.requestVerificationCodeUseCase = requestVerificationCodeUseCase
        self.signUpUseCase = signUpUseCase
        self.validateUseCase = validateUseCase
    }
    
    func transform(input: Input) -> Output {
        let nicknameValidationResult = input.nickname
            .map { [weak self] nickname in
                self?.validateUseCase.execute(nickname: nickname)
            }
            .map { error -> SignUpValidationResult in
                let isValid: Bool
                let message: String?
                
                if let error = error {
                    isValid = false
                    switch error {
                    case .tooShort:
                        message = "2자 이상이어야 합니다."
                    default:
                        message = "사용할 수 없는 닉네임입니다."
                    }
                } else {
                    isValid = true
                    message = "사용 가능한 닉네임입니다."
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .asDriver(onErrorJustReturn: SignUpValidationResult(isValid: false, message: nil))
        
        let emailValidationResult = input.email
            .map { [weak self] email in
                self?.validateUseCase.execute(email: email)
            }
            .map { error -> SignUpValidationResult in
                let isValid: Bool
                let message: String?
                
                if let error = error {
                    isValid = false
                    switch error {
                    case .incorrectFormat:
                        message = "이메일 형식에 맞지 않습니다."
                    default:
                        message = "사용할 수 없는 이메일입니다."
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .asDriver(onErrorJustReturn: SignUpValidationResult(isValid: false, message: nil))
        
        let verificationCodeRequest = input.requestButtonTouched
            .asObservable()
            .withLatestFrom(input.email.asObservable()) { $1 }
            .flatMap { [weak self] email -> Observable<VerificationCodeRequestResult?> in
                guard let self = self else { return .just(nil) }
                return self.requestVerificationCodeUseCase
                    .execute(userType: self.userType, email: email)
            }
        
        let verificationCodeRequestResult = verificationCodeRequest
            .asDriver(onErrorJustReturn: nil)
            .map {
                guard let result = $0 else {
                    return SignUpValidationResult(isValid: false,
                                                  message: "인증번호 발송 실패. 다시 시도해주세요.")
                }
                
                let isValid: Bool
                let message: String?
                
                if let error = result.error {
                    switch error {
                    case .alreadyExist:
                        isValid = false
                        message = "이미 가입된 이메일입니다."
                    case .invalidFormat:
                        isValid = false
                        message = "이메일 형식이 올바르지 않습니다."
                    }
                } else {
                    isValid = true
                    message = "인증번호가 발송되었습니다."
                }
                
                return SignUpValidationResult(isValid: isValid,
                                              message: message)
            }
        
        let verificationCode = verificationCodeRequest
            .compactMap { $0?.verificationCode }
        
        let verificationCodeValidationResult = input.verificationCode
            .asObservable()
            .withLatestFrom(verificationCode) { ($0, $1) }
            .map { [weak self] in
                self?.validateUseCase.execute(userEnteredVerificationCode: $0.0,
                                              actualVerificationCode: $0.1)
            }
            .map { error -> SignUpValidationResult in
                let isValid: Bool
                let message: String?
                
                if let error = error {
                    isValid = false
                    switch error {
                    case .mismatch:
                        message = "인증번호가 일치하지 않습니다."
                    default:
                        message = "인증에 실패하였습니다"
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .asDriver(onErrorJustReturn: SignUpValidationResult(isValid: false, message: nil))

        
        let passwordValidationResult = input.password
            .map { [weak self] password in
                return self?.validateUseCase.execute(password: password)
            }
            .map { error -> SignUpValidationResult in
                let isValid: Bool
                let message: String?
                
                if let error = error {
                    isValid = false
                    switch error {
                    case .tooShort:
                        message = "10자 이상이어야 합니다."
                    case .containsCharactersThatAreNotAllowed:
                        message = "영문과 특수문자만 사용 가능합니다."
                    default:
                        message = "사용할 수 없는 비밀번호 입니다."
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .asDriver(onErrorJustReturn: SignUpValidationResult(isValid: false, message: nil))
        
        let passwordConfirmValidationResult = input.passwordConfirm
            .withLatestFrom(input.password) { ($0, $1) }
            .map { [weak self] in
                self?.validateUseCase.execute(passwordConfirm: $0.0,
                                              password: $0.1)
            }
            .map { validationError -> SignUpValidationResult in
                let isValid: Bool
                let message: String?
                
                if let error = validationError {
                    isValid = false
                    switch error {
                    case .mismatch:
                        message = "입력한 비밀번호와 일치하지 않습니다."
                    default:
                        message = nil
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .asDriver(onErrorJustReturn: SignUpValidationResult(isValid: false, message: nil))
        
        return Output(nicknameValidationResult: nicknameValidationResult,
                      emailValidationResult: emailValidationResult,
                      verificationCodeRequestResult: verificationCodeRequestResult,
                      verificationCodeValidationResult: verificationCodeValidationResult,
                      passwordValidationResult: passwordValidationResult,
                      passwordConfirmValidationResult: passwordValidationResult)
    }
}

extension SignUpViewModel {
    struct Input {
        let nickname: Signal<String>
        let email: Signal<String>
        let verificationCode: Signal<String>
        let password: Signal<String>
        let passwordConfirm: Signal<String>
        let requestButtonTouched: Driver<Void>
        let signUpButtonTouched: Driver<Void>
    }
    
    struct Output {
        let nicknameValidationResult: Driver<SignUpValidationResult>
        let emailValidationResult: Driver<SignUpValidationResult>
        let verificationCodeRequestResult: Driver<SignUpValidationResult>
        let verificationCodeValidationResult: Driver<SignUpValidationResult>
        let passwordValidationResult: Driver<SignUpValidationResult>
        let passwordConfirmValidationResult: Driver<SignUpValidationResult>
    }
}
