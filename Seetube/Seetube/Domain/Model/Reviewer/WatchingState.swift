//
//  WatchingState.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/21.
//

import Foundation

enum WatchingState {
    case trackerInitializationFailed
    case trackerInitializationSucceeded
    case trackingStarted
    case trackingStoppped
    case calibrationPending
    case calibrationStartSucceeded
    case calibrationStartFailed
    case calibrationFailed
    case calibrationFinished
    case failedToGetImage
}
