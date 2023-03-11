//
//  SceneItemViewModel.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation

class SceneItemViewModel {
    enum ProgressBarColors {
        case red
        case black
        case indigo
        case yellow
        case blue
        case orange
        case gray
    }
    
    let thumbnailUrl: String
    let interval: String
    let description: String
    let progress: Double
    let progressDescription: String
    let color: ProgressBarColors?
    
    init(
        thumbnailUrl: String,
        interval: String,
        description: String,
        progress: Double,
        progressDescription: String,
        color: ProgressBarColors? = nil
    ) {
        self.thumbnailUrl = thumbnailUrl
        self.interval = interval
        self.description = description
        self.progress = progress
        self.progressDescription = progressDescription
        self.color = color
    }
    
    convenience init(with scene: ConcentrationScene) {
        let interval = StringFormattingHelper.toTimeIntervalFormatString(startSecond: scene.startTime,
                                                                         endSecond: scene.endTime)
        
        let description = "총 \(scene.totalNumberOfReviewers)명 중에\n\(scene.numberOfReviewersConcentrated)명이 집중했습니다."
        
        let total = Double(scene.totalNumberOfReviewers)
        let concentrated = Double(scene.numberOfReviewersConcentrated)
        let progress = concentrated / total
        let progressDescription = "\(Int(progress * 100))%"
        
        self.init(thumbnailUrl: scene.thumbnailImageURL,
                  interval: interval,
                  description: description,
                  progress: progress,
                  progressDescription: progressDescription)
    }
    
    convenience init(with scene: EmotionScene) {
        let interval = StringFormattingHelper.toTimeIntervalFormatString(startSecond: scene.startTime,
                                                                         endSecond: scene.endTime)
        
        let description = "총 \(scene.totalNumberOfReviewers)명 중에 \(scene.numberOfReviewersFelt)명이\n\(scene.emotionType.korDescription)을(를) 느꼈습니다."
        
        var emoticon: String {
            switch scene.emotionType {
            case .angry: return "😡"
            case .disgust: return "🤮"
            case .fear: return "😱"
            case .happy: return "😊"
            case .sad: return "😢"
            case .surprise: return "😲"
            case .neutral: return "😐"
            }
        }
        let total = Double(scene.totalNumberOfReviewers)
        let felt = Double(scene.numberOfReviewersFelt)
        let progress = felt / total
        let progressDescription = emoticon + "\n\(Int(progress * 100))%"
        
        var color: ProgressBarColors {
            switch scene.emotionType {
            case .angry: return .red
            case .disgust: return .black
            case .fear: return .indigo
            case .happy: return .yellow
            case .sad: return .blue
            case .surprise: return .orange
            case .neutral: return .gray
            }
        }
        
        self.init(thumbnailUrl: scene.thumbnailImageURL,
                  interval: interval,
                  description: description,
                  progress: progress,
                  progressDescription: progressDescription,
                  color: color)
    }
    
    convenience init(with scene: SceneStealerScene) {
        let interval = StringFormattingHelper.toTimeIntervalFormatString(startSecond: scene.startTime,
                                                                         endSecond: scene.endTime)
        let description = "해당 장면에서 집중도가\n\(scene.percentageOfConcentration)%로 가장 높았습니다."
        let progressDescription = "\(scene.percentageOfConcentration)%"
        
        self.init(thumbnailUrl: scene.imageURL,
                  interval: interval,
                  description: description,
                  progress: Double(scene.percentageOfConcentration),
                  progressDescription: progressDescription)
    }
}
