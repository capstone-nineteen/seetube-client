//
//  HighlightResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct HighlightsDTO: Decodable, DomainConvertible {
    let videoURL: String
    let numOfTotalReviewers: Int
    
    let firstSceneStartTimeInOriginalVideo: Float
    let firstSceneEndTimeInOriginalVideo: Float
    let firstSceneStartTimeInHighlight: Float
    let firstSceneEndTimeInHighlight: Float
    let numberOfReviewersConcentratedInFirstScene: Int
    let numberOfReviewersFeltInFirstScene: Int
    let emotionTypeInFirstScene: String
    let thumbnailURLInFirstScene: String
    
    let secondSceneStartTimeInOriginalVideo: Float?
    let secondSceneEndTimeInOriginalVideo: Float?
    let secondSceneStartTimeInHighlight: Float?
    let secondSceneEndTimeInHighlight: Float?
    let numberOfReviewersConcentratedInSecondScene: Int?
    let numberOfReviewersFeltInSecondScene: Int?
    let emotionTypeInSecondScene: String?
    let thumbnailURLInSecondScene: String?
    
    let thirdSceneStartTimeInOriginalVideo: Float?
    let thirdSceneEndTimeInOriginalVideo: Float?
    let thirdSceneStartTimeInHighlight: Float?
    let thirdSceneEndTimeInHighlight: Float?
    let numberOfReviewersConcentratedInThirdScene: Int?
    let numberOfReviewersFeltInThirdScene:Int?
    let emotionTypeInThirdScene: String?
    let thumbnailURLInThirdScene: String?
    
    let fourthSceneStartTimeInOriginalVideo:Float?
    let fourthSceneEndTimeInOriginalVideo: Float?
    let fourthSceneStartTimeInHighlight: Float?
    let fourthSceneEndTimeInHighlight: Float?
    let numberOfReviewersConcentratedInFourthScene: Int?
    let numberOfReviewersFeltInFourthScene: Int?
    let emotionTypeInFourthScene: String?
    let thumbnailURLInFourthScene: String?
    
    let fifthSceneStartTimeInOriginalVideo: Float?
    let fifthSceneEndTimeInOriginalVideo: Float?
    let fifthSceneStartTimeInHighlight: Float?
    let fifthSceneEndTimeInHighlight: Float?
    let numberOfReviewersConcentratedInFifthScene: Int?
    let numberOfReviewersFeltInFifthScene: Int?
    let emotionTypeInFifthScene: String?
    let thumbnailURLInFifthScene: String?
    
    enum CodingKeys: String, CodingKey {
        case videoURL
        case numOfTotalReviewers
        
        case firstSceneStartTimeInOriginalVideo = "FirstSceneStartTimeInOriginalVideo"
        case firstSceneEndTimeInOriginalVideo = "FirstSceneEndTimeInOriginalVideo"
        case firstSceneStartTimeInHighlight = "FirstSceneStartTimeInHighlight"
        case firstSceneEndTimeInHighlight = "FirstSceneEndTimeInHighlight"
        case numberOfReviewersConcentratedInFirstScene
        case numberOfReviewersFeltInFirstScene
        case emotionTypeInFirstScene
        case thumbnailURLInFirstScene
        
        case secondSceneStartTimeInOriginalVideo = "SecondSceneStartTimeInOriginalVideo"
        case secondSceneEndTimeInOriginalVideo = "SecondSceneEndTimeInOriginalVideo"
        case secondSceneStartTimeInHighlight = "SecondSceneStartTimeInHighlight"
        case secondSceneEndTimeInHighlight = "SecondSceneEndTimeInHighlight"
        case numberOfReviewersConcentratedInSecondScene
        case numberOfReviewersFeltInSecondScene
        case emotionTypeInSecondScene
        case thumbnailURLInSecondScene
        
        case thirdSceneStartTimeInOriginalVideo = "ThirdSceneStartTimeInOriginalVideo"
        case thirdSceneEndTimeInOriginalVideo = "ThirdSceneEndTimeInOriginalVideo"
        case thirdSceneStartTimeInHighlight = "ThirdSceneStartTimeInHighlight"
        case thirdSceneEndTimeInHighlight = "ThirdSceneEndTimeInHighlight"
        case numberOfReviewersConcentratedInThirdScene
        case numberOfReviewersFeltInThirdScene
        case emotionTypeInThirdScene
        case thumbnailURLInThirdScene
        
        case fourthSceneStartTimeInOriginalVideo = "FourthSceneStartTimeInOriginalVideo"
        case fourthSceneEndTimeInOriginalVideo = "FourthSceneEndTimeInOriginalVideo"
        case fourthSceneStartTimeInHighlight = "FourthSceneStartTimeInHighlight"
        case fourthSceneEndTimeInHighlight = "FourthSceneEndTimeInHighlight'"
        case numberOfReviewersConcentratedInFourthScene
        case numberOfReviewersFeltInFourthScene
        case emotionTypeInFourthScene
        case thumbnailURLInFourthScene
        
        case fifthSceneStartTimeInOriginalVideo = "FifthSceneStartTimeInOriginalVideo"
        case fifthSceneEndTimeInOriginalVideo = "FifthSceneEndTimeInOriginalVideo"
        case fifthSceneStartTimeInHighlight = "FifthSceneStartTimeInHighlight"
        case fifthSceneEndTimeInHighlight = "FifthSceneEndTimeInHighlight"
        case numberOfReviewersConcentratedInFifthScene
        case numberOfReviewersFeltInFifthScene
        case emotionTypeInFifthScene
        case thumbnailURLInFifthScene
    }
    
    func toDomain() -> HighlightResult {
        let maxNumberOfScenes = 5
        
        let thumbnailImageURLs = [thumbnailURLInFirstScene,
                                  thumbnailURLInSecondScene,
                                  thumbnailURLInThirdScene,
                                  thumbnailURLInFourthScene,
                                  thumbnailURLInFifthScene]
        let startTimesInOriginalVideo = [firstSceneStartTimeInOriginalVideo,
                                         secondSceneStartTimeInOriginalVideo,
                                         thirdSceneStartTimeInOriginalVideo,
                                         fourthSceneStartTimeInOriginalVideo,
                                         fifthSceneStartTimeInOriginalVideo]
        let endTimesInOriginalVideo = [firstSceneEndTimeInOriginalVideo,
                                       secondSceneEndTimeInOriginalVideo,
                                       thirdSceneEndTimeInOriginalVideo,
                                       fourthSceneEndTimeInOriginalVideo,
                                       fifthSceneEndTimeInOriginalVideo]
        let startTimesInHighlight = [firstSceneStartTimeInHighlight,
                                     secondSceneStartTimeInHighlight,
                                     thirdSceneStartTimeInHighlight,
                                     fourthSceneStartTimeInHighlight,
                                     fifthSceneStartTimeInHighlight]
        let endTimesInHighlight = [firstSceneEndTimeInHighlight,
                                   secondSceneEndTimeInHighlight,
                                   thirdSceneEndTimeInHighlight,
                                   fourthSceneEndTimeInHighlight,
                                   fifthSceneEndTimeInHighlight]
        let numbersOfReviewersConcentrated = [numberOfReviewersConcentratedInFirstScene,
                                              numberOfReviewersConcentratedInSecondScene,
                                              numberOfReviewersConcentratedInThirdScene,
                                              numberOfReviewersConcentratedInFourthScene,
                                              numberOfReviewersConcentratedInFifthScene]
        let numbersOfReviewersFelt = [numberOfReviewersFeltInFirstScene,
                                      numberOfReviewersFeltInSecondScene,
                                      numberOfReviewersFeltInThirdScene,
                                      numberOfReviewersFeltInFourthScene,
                                      numberOfReviewersFeltInFifthScene]
        let emotionTypes = [emotionTypeInFirstScene,
                            emotionTypeInSecondScene,
                            emotionTypeInThirdScene,
                            emotionTypeInFourthScene,
                            emotionTypeInFifthScene]
        
        let scenes = (0..<maxNumberOfScenes).map { index -> HighlightScene? in
            guard let thumbnailImageURL = thumbnailImageURLs[index],
                  let startTimeInOriginalVideo = startTimesInOriginalVideo[index],
                  let endTimeInOriginalVideo = endTimesInOriginalVideo[index],
                  let startTimeInHighlight = startTimesInHighlight[index],
                  let endTimeInHighlight = endTimesInHighlight[index],
                  let numberOfReviewersConcentrated = numbersOfReviewersConcentrated[index],
                  let numberOfReviewersFelt = numbersOfReviewersFelt[index],
                  let emotionType = emotionTypes[index] else { return nil }
                
            return HighlightScene(thumbnailImageURL: thumbnailImageURL,
                                  startTimeInOriginalVideo: startTimeInOriginalVideo,
                                  endTimeInOriginalVideo: endTimeInOriginalVideo,
                                  startTimeInHighlight: startTimeInHighlight,
                                  endTimeInHighlight: endTimeInHighlight,
                                  totalNumberOfReviewers: self.numOfTotalReviewers,
                                  numberOfReviewersConcentrated: numberOfReviewersConcentrated,
                                  numberOfReviewersFelt: numberOfReviewersFelt,
                                  emotionType: Emotion(rawValue: emotionType) ?? .neutral)
            }.compactMap{ $0 }
        
        return HighlightResult(highlightVideoURL: self.videoURL, scenes: scenes)
    }
}

struct HighlightResultDTO: Decodable, DomainConvertible {
    let highlight: HighlightsDTO
    
    func toDomain() -> HighlightResult {
        return highlight.toDomain()
    }
}
