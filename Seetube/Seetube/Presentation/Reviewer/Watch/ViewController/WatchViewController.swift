//
//  CalibraiontViewController.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/19.
//

import UIKit
import SeeSo
import CoreMedia
import AVFoundation

class WatchViewController: UIViewController {
    @IBOutlet weak var caliPointView: CircularProgressBar!

    private var gazeTracker: GazeTracker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async { [weak self] in
            self?.startEyeTracking()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let watchViewController = segue.description as? VideoPlayerViewController {
            // TODO: Watch ViewModel 주입
        }
    }
}

// MARK: - Eye Tracking

extension WatchViewController {
    private func startEyeTracking() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            self.initializeGazeTracker()
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] response in
                if response {
                    self?.initializeGazeTracker()
                }
            }
        }
    }
    
    private func initializeGazeTracker() {
        GazeTracker.initGazeTracker(license: SeeSo.licenseKey,
                                    delegate: self)
    }
}

// MARK: InitializationDelegate

extension WatchViewController: InitializationDelegate {
    func onInitialized(tracker: GazeTracker?, error: InitializationError) {
        if (tracker != nil) {
            self.gazeTracker = tracker
            self.gazeTracker?.setDelegates(statusDelegate: self,
                                           gazeDelegate: self,
                                           calibrationDelegate: self,
                                           imageDelegate: self)
            DispatchQueue.global().async { [weak self] in
                self?.gazeTracker?.startTracking()
            }
        } else {
            print("ERROR: failed to initialize gaze tracker \(error.description)")
        }
    }
}

// MARK: StatusDelegate

extension WatchViewController: StatusDelegate {
    func onStarted() {
        print("DEBUG: Tracker starts tracking")
        self.startCalibration()
    }
    
    func onStopped(error: StatusError) {
        print("ERROR: Tracking is stopped - \(error.description)")
    }
}


// MARK: Calibration

extension WatchViewController {
    private func startCalibration() {
        let result = self.gazeTracker?.startCalibration(mode: .FIVE_POINT, criteria: .HIGH)
        if let isStart = result,
           !isStart {
            print("ERROR: Calibration start failed")
        } else {
            print("DEBUG: Calibration start success")
        }
    }
    
    private func stopCalibration(){
        self.gazeTracker?.stopCalibration()
        self.caliPointView.isHidden = true
    }
}



// MARK: CalibrationDelegate

extension WatchViewController : CalibrationDelegate {
    func onCalibrationProgress(progress: Double) {
        caliPointView.setProgress(value: progress,
                                  text: "",
                                  color: Colors.seetubePink)
    }
    
    func onCalibrationNextPoint(x: Double, y: Double) {
        DispatchQueue.main.async {
            self.caliPointView.center = CGPoint(x: x, y: y)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if let result = self.gazeTracker?.startCollectSamples() {
                print("DEBUG: startCollectSamples : \(result)")
            }
        })
    }
    
    func onCalibrationFinished(calibrationData : [Double]) {
        print("DEBUG: Calibration finished")
        self.gazeTracker?.stopCalibration()
        self.caliPointView.isHidden = true
        // TODO: 비디오 플레이
    }
}

// MARK: GazeDelegate

extension WatchViewController: GazeDelegate {
    func onGaze(gazeInfo : GazeInfo) {
        guard let isCalibrating = self.gazeTracker?.isCalibrating(),
              !isCalibrating else { return }
        // TODO: Gaze Info 업데이트
        self.caliPointView.isHidden = false
        self.caliPointView.center = CGPoint(x: gazeInfo.x, y: gazeInfo.y)
    }
}

// MARK: ImageDelegate

extension WatchViewController: ImageDelegate {
    func onImage(timestamp: Double, image: CMSampleBuffer) {
        DispatchQueue.global().async {
            guard let frame = CMSampleBufferGetImageBuffer(image) else {
                print("ERROR: unable to get image from sample buffer")
                return
            }
            // TODO: face detection
        }
    }
}
