//
//  ViewController.swift
//  Sing Me a Dress
//
//  Created by Harshita Gupta on 2/20/16.
//
//

import UIKit
import FDSoundActivatedRecorder

class ViewController: UIViewController {

    var timerTXDelay: NSTimer?
    var allowTX = true
    var currentPrincess = Princess.Empty.rawValue

    var princessByAudio: UInt8 = 0
    
    self.recorder = FDSoundActivatedRecorder()

    
    enum Princess : UInt8 {
        case Empty = 0, Belle = 1, Ariel = 2, Elsa, Tianna, Jasmine, Rapunzel
    }// Princess.Belle.rawValue is 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recorder.delegate = self
        self.recorder.startListening()
        
        // Watch Bluetooth connection
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("connectionChanged:"), name: BLEServiceChangedStatusNotification, object: nil)
        
        // Start the Bluetooth discovery process
        btDiscoverySharedInstance
     }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: BLEServiceChangedStatusNotification, object: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.stopTimerTXDelay()
    }
    
    //todo create version of func below
//    @IBAction func positionSliderChanged(sender: UISlider) {
//        self.sendPosition(UInt8(sender.value))
//    }
    
    
    func connectionChanged(notification: NSNotification) {
        // Connection status changed. Indicate on GUI.
        _ = notification.userInfo as! [String: Bool]
        
    }

    func sendPrincessNumber(newPrincess: UInt8) {
        // Valid position range: 0 to 180
        
        if !self.allowTX {
            return
        }
        
        // Validate value
        if newPrincess == currentPrincess {
            return
        }
            
        else if ((newPrincess < 0) || (newPrincess > 180)) {
            return
        }
        
        // Send position to BLE Shield (if service exists and is connected)
        if let bleService = btDiscoverySharedInstance.bleService {
            bleService.writePosition(newPrincess)
            currentPrincess = newPrincess;
            
            // Start delay timer
            self.allowTX = false
            if timerTXDelay == nil {
                timerTXDelay = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("timerTXDelayElapsed"), userInfo: nil, repeats: false)
            }
        }
    }

    
    
    //TODO figure out when this should run
    func timerTXDelayElapsed() {
        self.allowTX = true
        self.stopTimerTXDelay()
        
        // Send current slider position
        self.sendPrincessNumber(UInt8(princessByAudio))
    }
    
    func stopTimerTXDelay() {
        if self.timerTXDelay == nil {
            return
        }
        
        timerTXDelay?.invalidate()
        self.timerTXDelay = nil
    }
    

    
}


extension ViewController: FDSoundActivatedRecorderDelegate {
    /// A recording was triggered or manually started
    func soundActivatedRecorderDidStartRecording(recorder: FDSoundActivatedRecorder) {
        recorder.stopAndSaveRecording()

        //        progressView.progressTintColor = UIColor.redColor()
    }
    
    /// No recording has started or been completed after listening for `TOTAL_TIMEOUT_SECONDS`
    func soundActivatedRecorderDidTimeOut(recorder: FDSoundActivatedRecorder) {
//        progressView.progressTintColor = UIColor.blueColor()
    }
    
    /// The recording and/or listening ended and no recording was captured
    func soundActivatedRecorderDidAbort(recorder: FDSoundActivatedRecorder) {
//        progressView.progressTintColor = UIColor.blueColor()
    }
    
    /// A recording was successfully captured
    func soundActivatedRecorderDidFinishRecording(recorder: FDSoundActivatedRecorder, andSaved file: NSURL) {
        //send to google api and turn to text.
        savedURL = file
    }
}
