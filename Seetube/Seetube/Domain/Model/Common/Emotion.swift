//
//  Emotion.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

enum Emotion: String, Codable {
    case angry
    case disgust
    case fear
    case happy
    case sad
    case surprise
    case neutral
    
    var korDescription: String {
        switch self {
        case .angry: return "분노"
        case .disgust: return "불쾌"
        case .fear: return "공포"
        case .happy: return "행복"
        case .sad: return "슬픔"
        case .surprise: return "놀람"
        case .neutral: return "중립"
        }
    }
}
