//
//  Text.swift
//  Hard of Hearing
//
//  Created by 苏 on 2019/1/13.
//  Copyright © 2019 StarterHack. All rights reserved.
//

import UIKit
import Speech
import AudioToolbox

class Text: UIViewController {

    
    @IBOutlet weak var detectedTextLabel: UILabel!
    
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
        self.recordAndRecognizeSpeech()
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
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
                
                
            } else if let error1 = error1 {
                print(error1)
            }
        })
    }
    
    func endRecording() {
        self.audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request.endAudio()
        recognitionTask?.cancel()
    }

}
