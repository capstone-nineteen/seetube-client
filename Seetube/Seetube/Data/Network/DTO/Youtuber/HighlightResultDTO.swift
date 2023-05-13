//
//  HighlightResultDTO.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/06.
//

import Foundation

struct HighlightsDTO: Decodable, DomainConvertible {
    let thumbnailURL: String
    let numOfTotalReviewers: Int
    
    let firstSceneStartTimeInOriginalVideo: Int
    let firstSceneEndTimeInOriginalVideo: Int
    let firstSceneStartTimeInHighlight: Int
    let firstSceneEndTimeInHighlight: Int
    let numberOfReviewersConcentratedInFirstScene: Int
    let numberOfReviewersFeltInFirstScene: Int
    let emotionTypeInFirstScene: String
    
    let secondSceneStartTimeInOriginalVideo: Int?
    let secondSceneEndTimeInOriginalVideo: Int?
    let secondSceneStartTimeInHighlight: Int?
    let secondSceneEndTimeInHighlight: Int?
    let numberOfReviewersConcentratedInSecondScene: Int?
    let numberOfReviewersFeltInSecondScene: Int?
    let emotionTypeInSecondScene: String?
    
    let thirdSceneStartTimeInOriginalVideo: Int?
    let thirdSceneEndTimeInOriginalVideo: Int?
    let thirdSceneStartTimeInHighlight: Int?
    let thirdSceneEndTimeInHighlight: Int?
    let numberOfReviewersConcentratedInThirdScene: Int?
    let numberOfReviewersFeltInThirdScene:Int?
    let emotionTypeInThirdScene: String?
    
    let fourthSceneStartTimeInOriginalVideo:Int?
    let fourthSceneEndTimeInOriginalVideo: Int?
    let fourthSceneStartTimeInHighlight: Int?
    let fourthSceneEndTimeInHighlight: Int?
    let numberOfReviewersConcentratedInFourthScene: Int?
    let numberOfReviewersFeltInFourthScene: Int?
    let emotionTypeInFourthScene: String?
    
    let fifthSceneStartTimeInOriginalVideo: Int?
    let fifthSceneEndTimeInOriginalVideo: Int?
    let fifthSceneStartTimeInHighlight: Int?
    let fifthSceneEndTimeInHighlight: Int?
    let numberOfReviewersConcentratedInFifthScene: Int?
    let numberOfReviewersFeltInFifthScene: Int?
    let emotionTypeInFifthScene: String?
    
    func toDomain() -> [HighlightScene] {
        let maxNumberOfScenes = 5
        
        let thumbnailImageURLs: [String?] = []
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
        
        return (0..<maxNumberOfScenes)
            .map { index -> HighlightScene? in
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
            }
            .compactMap{ $0 }
    }
}

struct HighlightResultDTO: Decodable, DomainConvertible {
    let originalVideoURL: String
    let highlight: HighlightsDTO
    
    func toDomain() -> HighlightResult {
        return HighlightResult(highlightVideoURL: self.originalVideoURL,
                               scenes: self.highlight.toDomain())
    }
}
