//
//  ViewController.swift
//  Phone Vibration
//
//  Created by Mazui san on 2019-01-12.
//  Copyright © 2019 Mazui san. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeBackgroundColourToBlack(_ sender: Any) {
        //view.backgroundColor = UIColor.black
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        }
    
}

