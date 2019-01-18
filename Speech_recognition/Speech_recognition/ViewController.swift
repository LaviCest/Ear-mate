//
//  ViewController.swift
//  Speech_recognition
//
//  Created by Nipun Lamba on 2019-01-13.
//  Copyright © 2019 Nipun Lamba. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var templateText: UILabel!
    @IBOutlet weak var inputVoice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func startVoice(_ sender: UIButton) {
        
        
    }
}

