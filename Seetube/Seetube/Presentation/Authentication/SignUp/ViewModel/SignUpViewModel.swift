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
    // TODO: 타이머 유즈케이스
    
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
            .distinctUntilChanged()
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
                    case .empty:
                        message = nil
                    default:
                        message = "사용할 수 없는 닉네임입니다."
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .debug("nickname")
        
        let emailValidationResult = input.email
            .distinctUntilChanged()
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
                    case .empty:
                        message = nil
                    default:
                        message = "사용할 수 없는 이메일입니다."
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .debug("email")
        
        let verificationCodeRequest = input.requestButtonTouched
            .debug("touched!!!!")
            .withLatestFrom(input.email) { $1 }
            .debug("with latest from!!")
            .flatMap { [weak self] email -> Driver<VerificationCodeRequestResult?> in
                guard let self = self else { return .just(nil) }
                return self.requestVerificationCodeUseCase
                    .execute(userType: self.userType, email: email)
                    .asDriver(onErrorJustReturn: nil)
            }
            .debug("verificationCodeRequest")
        
        let verificationCodeRequestResult = verificationCodeRequest
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
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid,
                                              message: message)
            }
            .debug("verificationcodeRequestReulst")
        
        let verificationCode = verificationCodeRequest
            .compactMap { $0?.verificationCode }
            .debug("verificationCode")
        
        let verificationCodeValidationResult = input.verificationCode
            .distinctUntilChanged()
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
                    case .empty:
                        message = nil
                    default:
                        message = "인증에 실패하였습니다"
                    }
                } else {
                    isValid = true
                    message = "인증되었습니다."
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .asDriver(onErrorJustReturn: SignUpValidationResult(isValid: false, message: nil))
            .debug("verificationCode validation")

        
        let passwordValidationResult = input.password
            .distinctUntilChanged()
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
                    case .empty:
                        message = nil
                    default:
                        message = "사용할 수 없는 비밀번호 입니다."
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .debug("passwordvalidation")
        
        let passwordConfirmValidationResult = Driver
            .combineLatest(
                input.passwordConfirm.distinctUntilChanged(),
                input.password
            ) { ($0, $1) }
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
                    case .empty:
                        message = nil
                    default:
                        message = nil
                    }
                } else {
                    isValid = true
                    message = nil
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .debug("password confirm")
        
        let finalValidationResult = Driver
            .combineLatest(
                nicknameValidationResult,
                emailValidationResult,
                verificationCodeValidationResult,
                passwordValidationResult,
                passwordConfirmValidationResult
            ) {
                return [$0, $1, $2, $3, $4].allSatisfy { $0.isValid }
            }
            .startWith(false)
        
        return Output(nicknameValidationResult: nicknameValidationResult,
                      emailValidationResult: emailValidationResult,
                      verificationCodeRequestResult: verificationCodeRequestResult,
                      verificationCodeValidationResult: verificationCodeValidationResult,
                      passwordValidationResult: passwordValidationResult,
                      passwordConfirmValidationResult: passwordConfirmValidationResult,
                      finalValidationResult: finalValidationResult)
    }
}

extension SignUpViewModel {
    struct Input {
        let nickname: Driver<String>
        let email: Driver<String>
        let verificationCode: Driver<String>
        let password: Driver<String>
        let passwordConfirm: Driver<String>
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
        let finalValidationResult: Driver<Bool>
        // TODO: SignUpResult
    }
}
