//
//  FaceExpressionPredictor.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/21.
//

import Foundation
import Vision
import RxSwift
import CoreImage

enum FaceExpressionPredictionError: Error {
    case faceDetectionFailed
    case faceCroppingFailed
    case faceExpressionClassificationFailed
    case noPredictions
    case wrongPredictionType
}

class FaceExpressionPredictor {
    // MARK: - Static
    
    static func createFaceExpressionClassifier() -> VNCoreMLModel {
        guard let miniXception = try? MiniXception(configuration: MLModelConfiguration()),
              let miniXceptionVisionModel = try? VNCoreMLModel(for: miniXception.model)
        else {
            fatalError("Failed to create a MiniXception")
        }
        
        return miniXceptionVisionModel
    }
    
    static let faceExpressionClassifier = createFaceExpressionClassifier()
    
    struct Prediction: Encodable {
        let classification: Emotion
        let confidencePercentage: Int
    }
    
    // MARK: - Instance
    
    func makePredictions(for image: CVPixelBuffer) -> Observable<Prediction> {
        return self.detectFace(in: image)
            .withUnretained(self)
            .flatMap { obj, observations in
                obj.cropFace(from: image, with: observations)
            }
            .withUnretained(self)
            .flatMap { obj, cgImage in
                obj.classifyFaceExpression(cgImage)
            }
    }
    
    /// 카메라 프레임으로부터 얼굴을 탐지한다.
    private func detectFace(in image: CVPixelBuffer) -> Observable<[VNFaceObservation]> {
        return Observable<[VNFaceObservation]>.create { observer in
            let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
                if let results = request.results as? [VNFaceObservation] {
                    observer.onNext(results)
                } else {
                    observer.onError(FaceExpressionPredictionError.faceDetectionFailed)
                }
                observer.onCompleted()
            })
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image,
                                                            orientation: .down,
                                                            options: [:])
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try imageRequestHandler.perform([faceDetectionRequest])
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    /// 얼굴 탐지 결과를 바탕으로 얼굴 부분만 크롭한다.
    private func cropFace(from image: CVPixelBuffer, with observedFaces: [VNFaceObservation]) -> Observable<CGImage> {
        return Observable<CGImage>.create { observer in
            if let observedFace = observedFaces.first {
                let ciImage = CIImage(cvPixelBuffer: image).transformed(by: CGAffineTransform(rotationAngle: .pi))
                let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent)

                if let croppedImage = cgImage?.croppingDetectionBondingBox(to: observedFace.boundingBox) {
                    observer.onNext(croppedImage)
                } else {
                    observer.onError(FaceExpressionPredictionError.faceCroppingFailed)
                }
                observer.onCompleted()
            } else {
                observer.onError(FaceExpressionPredictionError.faceDetectionFailed)
            }
            
            return Disposables.create()
        }
    }
    
    /// 얼굴 이미지에 대해 표정 분석을 수행한다.
    private func classifyFaceExpression(_ image: CGImage) -> Observable<Prediction> {
        return Observable<Prediction>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            let faceExpressionClassificaitonRequest = self.createFaceExpressionClassificationRequest { result in
                switch result {
                case .success(let prediction):
                    observer.onNext(prediction)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            let requests: [VNRequest] = [faceExpressionClassificaitonRequest]
            let handler = VNImageRequestHandler(cgImage: image)
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform(requests)
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    typealias FaceExpressionPredictionHandler = (_ predications: Result<Prediction, Error>) -> Void
    
    /// CoreML Request를 생성한다.
    private func createFaceExpressionClassificationRequest(predictionHandler: @escaping FaceExpressionPredictionHandler) -> VNImageBasedRequest {
        let faceExpressionClassificationRequest = VNCoreMLRequest(model: Self.faceExpressionClassifier) { (request, error) in
            if let error = error {
                predictionHandler(.failure(error))
                return
            }
            
            if request.results == nil {
                predictionHandler(.failure(FaceExpressionPredictionError.noPredictions))
                return
            }
            
            guard let observations = request.results as? [VNClassificationObservation],
                  let observation = observations.first else {
                predictionHandler(.failure(FaceExpressionPredictionError.wrongPredictionType))
                return
            }
            
            let prediction = Prediction(classification: Emotion(rawValue: observation.identifier) ?? .neutral,
                                        confidencePercentage: Int(observation.confidence * 100))
            predictionHandler(.success(prediction))
        }
        
        faceExpressionClassificationRequest.imageCropAndScaleOption = .centerCrop
        return faceExpressionClassificationRequest
    }
}
