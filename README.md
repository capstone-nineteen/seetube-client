# Seetube: 영상 크리에이터를 위한, AI 기반 시청자 반응 분석 및 숏폼 자동 생성 서비스

<img src="https://github.com/capstone-nineteen/.github/assets/70833900/cf15e725-7443-4919-a2b9-b9b28d803b74" width=200>

## Introduction
디바이스 **전면카메라**를 사용하여 영상 콘텐츠 시청자의 **시선 및 표정 데이터** 분석합니다. (리뷰 참여자에게는 리워드를 제공합니다.) 분석 결과를 바탕으로 **2차 숏폼(Short-Form) 콘텐츠**를 제작하기에 적절한 장면 및 영역을 선정하여 **숏폼을 자동 생성**해주는 서비스입니다.

## Features

### 리뷰어
1. **시선 및 표정 분석**
    - 영상을 시청하는 리뷰어의 시선과 표정 리액션을 디바이스 전면 카메라를 통해 분석해줍니다.  
2. **리워드**
    - 영상 시청 완료 시 리워드를 제공합니다.
    - 어뷰징(영상 전체 시간의 20% 이상 얼굴/시선 이탈이 감지된 경우) 감지 시 리뷰를 강제 중단합니다.

### 영상 크리에이터
1. **집중도가 높았던 장면 확인**
    - 리뷰어들의 시선 데이터를 바탕으로 가장 집중도가 높았던 장면을 분석하여 제공합니다.
2. **감정이 감지된 장면 확인**
    - 리뷰어들의 표정 데이터를 바탕으로 많은 리뷰어가 공통의 감정을 느낀 장면을 분석하여 제공합니다.
3. **씬스틸러 분석 결과 확인**
    - 시선 데이터를 바탕으로 장면마다 가장 이목을 끈 객체(씬스틸러)를 분석하여 제공합니다.
4. **쇼츠 생성 결과 확인 및 다운로드**
    - 씬스틸러를 확대하여 9:16 비율로 재편집한 쇼츠를 자동 생성합니다.
    - 디바이스에 다운로드 가능합니다.
5. **하이라이트 생성 결과 확인 및 다운로드**
    - 집중도와 감정 분석 결과를 바탕으로 핵심 장면 5개를 이어 붙인 하이라이트 영상을 자동 생성합니다.
    - 디바이스에 다운로드 가능합니다.

## 화면
### 공통
|메인|로그인|회원 가입|
|:-:|:-:|:-:|
|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 08 14](https://github.com/capstone-nineteen/.github/assets/70833900/dbec684e-b372-4976-a1aa-0248d07b083b)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 08 33](https://github.com/capstone-nineteen/.github/assets/70833900/2e06ec36-9268-441d-a15b-4fbf2e713351)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 08 50](https://github.com/capstone-nineteen/.github/assets/70833900/62ed9148-d9cc-4065-9d9e-1e05a799ff8c)|

### 리뷰어

|홈|검색|카테고리|영상 상세|
|:-:|:-:|:-:|:-:|
|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 22 38 50](https://github.com/capstone-nineteen/seetube-client/assets/70833900/6f873f96-b9ec-4ba9-a478-0e9dd4ef6a30)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 10 31](https://github.com/capstone-nineteen/.github/assets/70833900/2f1edd6d-c797-412a-a1a1-1c7ca40820c1)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 22 41 32](https://github.com/capstone-nineteen/seetube-client/assets/70833900/8801c470-4592-4d2a-9709-3ef901a84be5)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 22 42 07](https://github.com/capstone-nineteen/seetube-client/assets/70833900/5cf582ff-8e60-4829-84cb-38590c67a834)|
|환급|환급 정보 입력|마이페이지||
|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 22 43 24](https://github.com/capstone-nineteen/seetube-client/assets/70833900/e00e72d7-21cc-4b72-8d53-68f4dea2752b)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 22 43 53](https://github.com/capstone-nineteen/seetube-client/assets/70833900/caf36502-a8e2-44be-b754-5220ba618c9a)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 22 44 01](https://github.com/capstone-nineteen/seetube-client/assets/70833900/cc94ce27-02db-4f04-99bb-dd627a041be1)||

|캘리브레이션-튜토리얼|캘리브레이션-진행|
|:-:|:-:|
|![](https://github.com/capstone-nineteen/.github/assets/70833900/3b5d59ee-ccf0-4e74-a224-151a1c07e262)|![](https://github.com/capstone-nineteen/.github/assets/70833900/2686fd69-382c-46fa-8a2b-6fcd054d1bc4)|

### 크리에이터

|홈|분석 결과 메뉴||
|:-:|:-:|:-:|
|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 06 35](https://github.com/capstone-nineteen/.github/assets/70833900/2d06ad67-61e9-4a5c-b8b9-a2795ac881b7)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 22 59 26](https://github.com/capstone-nineteen/seetube-client/assets/70833900/65359400-c37a-4768-8c31-4376a2185027)||
|집중도가 높았던 장면 분석 결과|감정이 감지된 장면 분석 결과|씬 스틸러 분석 결과|
|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 00 17](https://github.com/capstone-nineteen/seetube-client/assets/70833900/b591e9c1-d30a-4ed4-80e6-2f2a885668ef)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 00 25](https://github.com/capstone-nineteen/seetube-client/assets/70833900/fc4a5b76-e7c7-4a50-bdaf-0330299db44e)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 00 31](https://github.com/capstone-nineteen/seetube-client/assets/70833900/d831a595-5c98-41e1-a41d-73c373866966)|
|쇼츠 생성 결과|하이라이트 생성 결과||
|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 00 43](https://github.com/capstone-nineteen/seetube-client/assets/70833900/11d3081e-cfe1-4a03-afbb-07fcffe35709)|![Simulator Screenshot - iPhone 14 - 2023-05-30 at 23 00 58](https://github.com/capstone-nineteen/seetube-client/assets/70833900/cac6ef3c-f79a-49eb-8139-5f3bd09374e5)||

## Requirements
- iOS 14.0+
- iPhone 6s+
- Swift 5.0+
- SeeSo SDK - iOS 2.5.1
    1. [SeeSo Console](https://manage.seeso.io/#/console/)에 가입합니다.
    2. [SDK] 메뉴에서 iOS(Swift) 2.5.1 버전을 다운로드 받습니다. `SeeSo.xcframework`가 다운로드됩니다.
- SeeSo License Key
    - [License Keys] 메뉴에서 [Start free trial license]을 눌러 라이센스키를 발급받습니다.

## Installation
로컬 디바이스에서 Seetube를 실행하려면, 다음 단계를 따르세요.

1. `git clone https://github.com/capstone-nineteen/seetube-client.git`
2. Xcode에서 클론된 디렉토리를 엽니다.
3. `Seetube/Seetube/SeeSo.xcframework` 폴더를 다운로드 받은 SDK 폴더로 변경합니다.
4. 아래와 같은 내용으로 `APIKeys.xcconfig` 파일을 생성합니다. "발급받은 라이센스키 입력" 부분을 실제 라이센스 키로 변경하세요.
    ```
    SEESO_LICENSE_KEY = '발급 받은 라이센스키 입력'
    ```
5. 생성한 `APIKeys.xcconfig` 파일을 `seetube-client/Seetube/APIKeys.xcconfig` 경로에 추가합니다.
6. CocoaPods 또는 Swift Package Manager와 같은 패키지 관리자를 사용하여 필요한 종속성을 설치합니다.
7. 물리적 장치(시뮬레이터 불가)에서 SeeTube iOS 앱을 빌드하고 실행합니다.

## Resource
- SeeSo iOS SDK 2.5.1: 시선 추적 구현에 사용하였습니다.
- [Pre-trained MiniXception 모델](https://github.com/oarriaga/face_classification/blob/master/trained_models/fer2013_mini_XCEPTION.119-0.65.hdf5): Core ML 포맷으로 변환하여 표정 분석 구현에 사용하였습니다.

