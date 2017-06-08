//
//  ViewController.swift
//  Audio Recording
//
//  Created by Jin Kato on 6/7/17.
//  Copyright © 2017 Jin Kato. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: UI
    
    let recordButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Record", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(recordButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    let playButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(playButtonPressed(sender:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //MARK: Properties
    
    private var audioRecorder:AVAudioRecorder!
    private var audioPlayer:AVAudioPlayer!
    private let audioFileLocation = NSTemporaryDirectory().appending("audioRecording.m4a")
    private let audioRecorderSettings = [AVFormatIDKey : NSNumber.init(value: kAudioFormatAppleLossless),
                                         AVSampleRateKey : NSNumber.init(value: 44100.0),
                                         AVNumberOfChannelsKey : NSNumber.init(value: 1),
                                         AVLinearPCMBitDepthKey: NSNumber.init(value: 16),
                                         AVEncoderAudioQualityKey : NSNumber.init(value: AVAudioQuality.high.rawValue)]
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutRecordButton()
        layoutPlayButton()
        prepareAudioRecorder()
    }
    
    //MARK: Main
    
    func recordButtonPressed(sender:UIButton){
        if !audioRecorder.isRecording {
            startRecording()
        } else {
            stopRecording()
            checkRecordingFile()
        }
        updateRecordButtonTitle()
    }
    func playButtonPressed(sender:UIButton){
        playAudio()
    }
    
    //MARK: Helper
    
    fileprivate func playAudio(){
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFileLocation))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch{
            print(error)
        }
    }
    fileprivate func startRecording(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
            audioRecorder.record()
        } catch {
            print(error)
        }
    }
    fileprivate func stopRecording(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch {
            print(error)
        }
    }
    fileprivate func checkRecordingFile(){
        if verifyFileExists() {
            print("file exists")
            playButton.isHidden = false
        } else {
            print("There was a problem recording")
        }
    }
    fileprivate func prepareAudioRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(url: URL(fileURLWithPath: audioFileLocation), settings: audioRecorderSettings)
            audioRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    fileprivate func verifyFileExists() -> Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: audioFileLocation)
    }
    
    //MARK: UI Helper
    
    fileprivate func updateRecordButtonTitle() {
        if audioRecorder.isRecording {
            recordButton.setTitle("Recording..", for: .normal)
        } else {
            recordButton.setTitle("Record", for: .normal)
        }
    }
}

