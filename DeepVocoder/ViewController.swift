//
//  ViewController.swift
//  DeepVocoder
//
//  Created by Karthik Kannan on 17/02/17.
//  Copyright © 2017 Karthik Kannan. All rights reserved.
//

import UIKit
import Hero
import Spring
import AVFoundation

class ViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordButtonAnimated: SpringButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    
    
    @IBOutlet weak var recordStatus: UILabel! //Current status of the recording.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        recordButton.layer.cornerRadius = self.recordButton.frame.size.width/2
        recordButton.clipsToBounds = true
        view.layer.addSublayer(recordButton.layer)
        view.layer.addSublayer(recordStatus.layer)
        
    }

    func loadRecordingUI() {
        recordStatus.text = "Ready to record."
//        recordButtonAnimated.animation = "pop"
//        recordButtonAnimated.animate()
        recordButtonAnimated.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func startRecording() {
        let audioFileName = getDocumentsDirectory().appendingPathComponent("voc-recording.m4a")
        
        print(audioFileName)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordButtonAnimated.animation = "pop"
            recordButtonAnimated.animate()

            recordStatus.text = "Recording..."
            
        }
        catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordStatus.text = "Tap to re-record"
            
        }
        else {
            recordStatus.text = "Ready to record."
        }
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        }
        else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print("In VC")
        
        let layer = CAGradientLayer()
        layer.frame = view.frame
        layer.colors = [UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0).cgColor, UIColor(red:0.17, green:0.17, blue:0.17, alpha:1.0).cgColor]
        view.layer.addSublayer(layer)
        
        //Init AudioSession.
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    }
                    else {
                        print("error. Need to fix this.")
                    }
                }
            }
        }
        catch {
            print("Failed to record. Error!")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

