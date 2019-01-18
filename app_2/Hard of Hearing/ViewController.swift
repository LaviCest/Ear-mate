//
//  ViewController.swift
//  Hard of Hearing
//
//  Created by 苏 on 2019/1/13.
//  Copyright © 2019 StarterHack. All rights reserved.
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
    
    @IBOutlet weak var left1: UIButton!
    @IBOutlet weak var left2: UIButton!
    @IBOutlet weak var left3: UIButton!
    @IBOutlet weak var right1: UIButton!
    @IBOutlet weak var right2: UIButton!
    @IBOutlet weak var right3: UIButton!
    
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
    

    @IBAction func textButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segue_text", sender: self)
    }
    
    @IBAction func acountButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "segue_acount", sender: self)
        
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        print("unwind...")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //button
        left1.layer.cornerRadius = 12
        left2.layer.cornerRadius = 12
        left3.layer.cornerRadius = 12
        right1.layer.cornerRadius = 12
        right2.layer.cornerRadius = 12
        right3.layer.cornerRadius = 12
        
        self.recordAndRecognizeSpeechDefault()
        
        
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
                        self.performSegue(withIdentifier: "segue_text", sender: self)
                        
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

    
    func checkForTriggerWord(resultString: String) ->Bool {
        switch resultString {
        case "Hello":
            return true
        case "Hey":
            return true
        case "hey":
            return true
        case "hello":
            return true
        case "John":
            return true
        case "john":
            return true
        case "hi":
            return true
        case "Hi":
            return true
        default: return false
        }
    }

}

