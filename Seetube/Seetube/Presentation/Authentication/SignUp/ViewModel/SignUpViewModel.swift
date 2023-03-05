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
    private let countDownUseCase: CountDownUseCase
    
    init(
         userType: UserType,
         requestVerificationCodeUseCase: RequestVerificationCodeUseCase,
         signUpUseCase: SignUpUseCase,
         validateUseCase: ValidateSignUpInfoUseCase,
         countDownUseCase: CountDownUseCase
    ) {
        self.userType = userType
        self.requestVerificationCodeUseCase = requestVerificationCodeUseCase
        self.signUpUseCase = signUpUseCase
        self.validateUseCase = validateUseCase
        self.countDownUseCase = countDownUseCase
    }
    
    func transform(input: Input) -> Output {
        // nickname
        
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
        
        // email
        
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
        
        // verificaion code
        
        let verificationCodeRequest = input.requestButtonTouched
            .withLatestFrom(input.email) { $1 }
            .flatMap { [weak self] email -> Driver<VerificationCodeRequestResult?> in
                guard let self = self else { return .just(nil) }
                return self.requestVerificationCodeUseCase
                    .execute(userType: self.userType, email: email)
                    .asDriver(onErrorJustReturn: nil)
            }
        
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
        
        let remainingTime = verificationCodeRequest
            .filter { $0?.verificationCode != nil }
            .flatMap { [weak self] _ -> Driver<Int> in
                guard let self = self else { return .just(0) }
                return self.countDownUseCase
                    .execute(time: 30)
                    .asDriver(onErrorJustReturn: 0)
            }
        
        let verificationCodeExpired = remainingTime
            .map { $0 == 0 ? true : false }
            .startWith(true)
            .distinctUntilChanged()
        
        let verificationCode = Driver
            .combineLatest(
                verificationCodeRequest.map { $0?.verificationCode },
                verificationCodeExpired
            ) { $1 ? nil : $0 }
            .startWith(nil)
        
        let isVerificationCodeActive = verificationCode
            .map { $0 != nil }
        
        let verificationCodeValidationResult = input.verificationButtonTouched
            .withLatestFrom(input.verificationCode) { $1 }
            .distinctUntilChanged()
            .asObservable()
            .withLatestFrom(verificationCode) { (user: $0, actual: $1) }
            .map { [weak self] verificationCodes -> SignUpValidationError? in
                guard let actualVerificaitonCode = verificationCodes.actual else { return .empty }
                return self?.validateUseCase.execute(userEnteredVerificationCode: verificationCodes.user,
                                                     actualVerificationCode: actualVerificaitonCode)
            }
            .map { error -> SignUpValidationResult in
                let isValid: Bool
                let message: String?
                
                if let error = error {
                    isValid = false
                    switch error {
                    case .mismatch:
                        message = "인증번호 불일치"
                    case .empty:
                        message = nil
                    default:
                        message = "인증 실패"
                    }
                } else {
                    isValid = true
                    message = "인증 완료"
                }
                
                return SignUpValidationResult(isValid: isValid, message: message)
            }
            .startWith(SignUpValidationResult(isValid: false, message: nil))
            .asDriver(onErrorJustReturn: SignUpValidationResult(isValid: false, message: nil))
        
        // request verification code button
        
        let shouldEnableRequestButton = Driver
            .combineLatest(
                emailValidationResult,
                verificationCodeRequestResult,
                verificationCodeValidationResult,
                isVerificationCodeActive
            ) { ($0, $1, $2, $3) }
            .filter { $0.0.isValid && !$0.2.isValid && (!$0.3 || !$0.1.isValid) }
        
        let shouldDisableRequestButton = Driver
            .merge(
                input.requestButtonTouched,
                isVerificationCodeActive
                    .filter { $0 }
                    .mapToVoid(),
                verificationCodeValidationResult
                    .map { $0.isValid }
                    .filter { $0 }
                    .mapToVoid()
            )
            .debug("disable")
        
        let canRequest = Driver
            .merge(
                shouldEnableRequestButton.map { _ in true },
                shouldDisableRequestButton.map { _ in false }
            )
        
        // verify button
        
        let shouldEnableVerifyButton = isVerificationCodeActive
            .filter { $0 }
            .mapToVoid()
        
        let shouldDisableVerifyButton = Driver
            .merge(
                isVerificationCodeActive.filter { !$0 },
                verificationCodeValidationResult.map { $0.isValid }.filter { $0 }
            )
            .mapToVoid()
        
        let canVerify = Driver
            .merge(
                shouldEnableVerifyButton.map { _ in true },
                shouldDisableVerifyButton.map { _ in false }
            )
        
        // remaining time label
        
        let remainingTimeString = remainingTime
            .map { sec -> String? in
                return StringFormattingHelper.toTimeFormatString(seconds: sec)
            }
            .withLatestFrom(canVerify) { ($0, $1) }
            .map { $0.1 ? $0.0 : nil }

        // password
        
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
                        message = "영문과 숫자 및 특수문자만 사용 가능합니다."
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
        
        // password confirm
        
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
        
        // final validation result
        
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
        
        let signUpInfo = Driver
            .combineLatest(
                input.nickname,
                input.email,
                input.password
            ) { ($0, $1, $2) }
            .map {
                SignUpInformation(nickname: $0.0,
                                  email: $0.1,
                                  password: $0.2)
            }
        
        let signUpResult = input.signUpButtonTouched
            .withLatestFrom(signUpInfo) { $1 }
            .flatMap { [weak self] info -> Driver<Bool> in
                guard let self = self else { return .just(false) }
                return self.signUpUseCase
                    .execute(userType: self.userType, info: info)
                    .asDriver(onErrorJustReturn: false)
            }
        
        return Output(nicknameValidationResult: nicknameValidationResult,
                      emailValidationResult: emailValidationResult,
                      verificationCodeRequestResult: verificationCodeRequestResult,
                      verificationCodeValidationResult: verificationCodeValidationResult,
                      remainingVerificationTime: remainingTimeString,
                      canRequestVerificationCode: canRequest,
                      canVerify: canVerify,
                      passwordValidationResult: passwordValidationResult,
                      passwordConfirmValidationResult: passwordConfirmValidationResult,
                      finalValidationResult: finalValidationResult,
                      signUpResult: signUpResult)
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
        let verificationButtonTouched: Driver<Void>
    }
    
    struct Output {
        let nicknameValidationResult: Driver<SignUpValidationResult>
        let emailValidationResult: Driver<SignUpValidationResult>
        let verificationCodeRequestResult: Driver<SignUpValidationResult>
        let verificationCodeValidationResult: Driver<SignUpValidationResult>
        let remainingVerificationTime: Driver<String?>
        let canRequestVerificationCode: Driver<Bool>
        let canVerify: Driver<Bool>
        let passwordValidationResult: Driver<SignUpValidationResult>
        let passwordConfirmValidationResult: Driver<SignUpValidationResult>
        let finalValidationResult: Driver<Bool>
        let signUpResult: Driver<Bool>
    }
}
