//
//  ViewController.swift
//  Speech Recognition
//
//  Created by Prabhapaar Singh Batra on 2019-01-13.
//  Copyright © 2019 Prabhapaar Singh Batra. All rights reserved.
//

import UIKit
import Speech
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    
    @IBOutlet weak var detectedTextLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var triggerWord: UILabel!
    @IBOutlet weak var endButton: UIButton!
    
    let audioEngine = AVAudioEngine()
 //   let audioEngine1 = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
 //   let speechRecognizer1: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    let request1 = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
 //   var recognitionTask1: SFSpeechRecognitionTask?
//    var bestString1: String = ""
    var bestString: String = ""
    var lastString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordAndRecognizeSpeechDefault()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func startButtonTapped(_ sender: UIButton) {
        self.recordAndRecognizeSpeech()
    }
    

    @IBAction func endButtonTapped(_ sender: UIButton) {
        self.endRecording()
        self.detectedTextLabel.text = ""
    //    self.bestString1 = ""
        self.bestString = ""
    }
    
    
    func recordAndRecognizeSpeechDefault() {
        guard let node: AVAudioInputNode = audioEngine.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognizer.isAvailable {
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                self.bestString = result.bestTranscription.formattedString
                self.lastString = ""
                for segment in result.bestTranscription.segments {
                    let indexTo = self.bestString.index(self.bestString.startIndex, offsetBy: segment.substringRange.location)
                    self.lastString = self.bestString.substring(from: indexTo)
                    
                    if self.checkForTriggerWord(resultString: self.lastString) {
                        self.endRecording()
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        self.recordAndRecognizeSpeech()
                    }
                }
                
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func endRecording() {
        
    self.audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
    request.endAudio()
    recognitionTask?.cancel()
    
        
    }
    
    
    func recordAndRecognizeSpeech() {
        guard let node: AVAudioInputNode = audioEngine.inputNode else { return }
         let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in self.request1.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            // A recognizer is not supported for current locale
            return
        }
        if !myRecognizer.isAvailable {
            // A recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request1, resultHandler: { result, error1 in
            if let result = result {
                self.bestString = result.bestTranscription.formattedString
                self.detectedTextLabel.text = self.bestString
                
             // var lastString: String = ""
              //  for segment in result.bestTranscription.segments {
             //       let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
            //        lastString = bestString.substring(from: indexTo)
            //   }
                
            } else if let error1 = error1 {
                print(error1)
            }
        })
    }
    
    
    func checkForTriggerWord(resultString: String) ->Bool {
        switch resultString {
        case "Hello":
            return true
        case "Hey":
            return true
        case "hey":
            return true
        case "rain":
            return true
        case "cat":
            return true
        case "dog":
            return true
        default: return false
        }
        
    }
   
}

