//
//  ViewController.swift
//  SettingPage
//
//  Created by 苏 on 2019/1/13.
//  Copyright © 2019 StarterHack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBAction func settingButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "segue_setting", sender: self)
        
        
        //get rid of keyboard
        
        
        
        
        
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        print("unwind...")
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

