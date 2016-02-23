//
//  ViewController.swift
//  Sing Me a Dress
//
//  Created by Harshita Gupta on 2/20/16.
//
//

import UIKit
import AVKit
import AVFoundation
import AWSS3
import AWSCore
import AWSCognito

class ViewController: UIViewController {

    var timerTXDelay: NSTimer?
    var allowTX = true
    var currentPrincess = Princess.Empty.rawValue

    var princessByAudio: UInt8 = 0
    
    var recorder = FDSoundActivatedRecorder()
    
    enum Princess : UInt8 {
        case Empty = 0, Ariel , Jasmine, Rapunzel, Belle, Riana, Elsa, Esmerelda, Pocahontas, Meg
    }// Princess.Belle.rawValue is 1
    
    let contentToPrincessMap = [ "": Princess.Ariel, "": Princess.Belle, "1456069915-3a859738-db0b-4ef8-a1a6-4ff5f5fc067b-5321962399": Princess.Meg]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorder.delegate = self
        
        let audioSession = AVAudioSession.sharedInstance()
        _ = try? audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        _ = try? audioSession.setActive(true)

        
//        self.clipsRef = rootRef.childByAppendingPath("audioclips")
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
        print("started recording");
        //        progressView.progressTintColor = UIColor.redColor()
    }
    
    /// No recording has started or been completed after listening for `TOTAL_TIMEOUT_SECONDS`
    func soundActivatedRecorderDidTimeOut(recorder: FDSoundActivatedRecorder) {
      print("timeout")
//        progressView.progressTintColor = UIColor.blueColor()
    }
    
    /// The recording and/or listening ended and no recording was captured
    func soundActivatedRecorderDidAbort(recorder: FDSoundActivatedRecorder) {
        print("abort")
        //        progressView.progressTintColor = UIColor.blueColor()
    }
    
    /// A recording was successfully captured
    func soundActivatedRecorderDidFinishRecording(recorder: FDSoundActivatedRecorder, andSaved file: NSURL) {
        print("done recording")

        var storedUrl  = urlHostingFile(file)
        
        getPrincessForClipURL(storedUrl)
        
        
    }
}

func getPrincessForClipURL(clipURL: NSURL) -> UInt8 {
    
    var contentid : String = ""

    let upReq = NSMutableURLRequest(URL: NSURL(fileURLWithPath: "https://api.deepgram.com"))

    upReq.HTTPMethod = "POST"
//    let postString = "id=13&name=Jack"
    upReq.setValue("Content-Type", forHTTPHeaderField: "application/json")
    let body: String = "{ \"action\": \"index_content\", \"userID\": \"1455954858-2bce8b77-3ed2-48d9-bad3-f6b09a409c18-8400380963332358625873095585037\", \"data_url\" : " + String(clipURL) +  "}"
    upReq.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
    let task = NSURLSession.sharedSession().dataTaskWithRequest(upReq) { data, response, error in
        guard error == nil && data != nil else {                                                          // check for fundamental networking error
            print("error=\(error)")
            return
        }
        
        if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response)")
        }
        
        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        contentid = String(responseString)
        print("responseString = \(responseString)")
    }
    task.resume()
    
    // downloading file transcript
    
    var transcript = ""
    
    let transRew = NSMutableURLRequest(URL: NSURL(fileURLWithPath: "https://api.deepgram.com"))
    
    transRew.HTTPMethod = "POST"
    //    let postString = "id=13&name=Jack"
    transRew.setValue("Content-Type", forHTTPHeaderField: "application/json")
    let body2: String = "{ \"action\": \"get_object_transcript\", \"userID\":  \"1455954858-2bce8b77-3ed2-48d9-bad3-f6b09a409c18-8400380963332358625873095585037\", \"contentID\": \"" + String(contentid) +  "}"
    transRew.HTTPBody = body2.dataUsingEncoding(NSUTF8StringEncoding)
    let task2 = NSURLSession.sharedSession().dataTaskWithRequest(transRew) { data, response, error in
        guard error == nil && data != nil else {                                                          // check for fundamental networking error
            print("error=\(error)")
            return
        }
        
        if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response)")
        }
        
        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        transcript = String(responseString)
        print("responseString = \(responseString)")
    }
    task2.resume()

    var resultsDict = []
    for (contentid, princess) in self.contentToPrincessMap {
        resultsDict[contentid] = 0
    }
    
    
    for (contentid, princess) in contentToPrincessMap {
        var queryResults = ""
        
        let qReq = NSMutableURLRequest(URL: NSURL(fileURLWithPath: "https://api.deepgram.com"))
        
        qReq.HTTPMethod = "POST"
        //    let postString = "id=13&name=Jack"
        qReq.setValue("Content-Type", forHTTPHeaderField: "application/json")
        let bodyn: String = "{ \"action\": \"object_search\", \"userID\": \"1455954858-2bce8b77-3ed2-48d9-bad3-f6b09a409c18-8400380963332358625873095585037\", \"contentID\": \" " + contentid + "\", \"query\": \"" + transcript + "\", \"snippet\": true, \"filter\": {\"Nmax\": 10, \"Pmin\": 0.65 }, \"sort\": \"time\" }"
        qReq.HTTPBody = bodyn.dataUsingEncoding(NSUTF8StringEncoding)
        let taskn = NSURLSession.sharedSession().dataTaskWithRequest(qReq) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            transcript = String(responseString)
            queryResults = responseString
            print("responseString = \(responseString)")
        }
        taskn.resume()

    }
    
    
    
    
    
    
    
    
    
    
    
}

func urlHostingFile(file : NSURL) -> NSURL {
    
    let transferManager = AWSS3TransferManager.defaultS3TransferManager()

    let uploadReq = AWSS3TransferManagerUploadRequest()
    let bucket = "singmeadressaudios"
    uploadReq.bucket = bucket
    let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
    let name = "audFile " + timestamp
    uploadReq.key = name
    uploadReq.body  = file
    
    let task = transferManager.upload(uploadReq)
    task.continueWithBlock { (task) -> AnyObject! in
        if task.error != nil {
            print("Error: \(task.error)")
        } else {
            print("Upload successful")
        }
        return nil
    }
    
    let urlString = "https://s3.amazonaws.com/" + bucket + "/" + name + ".jpg"
    return NSURL(string: urlString)!
    
}
