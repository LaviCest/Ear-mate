//
//  ViewController.swift
//  Hard of Hearing
//
//  Created by 苏 on 2019/1/13.
//  Copyright © 2019 StarterHack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var left1: UIButton!
    @IBOutlet weak var left2: UIButton!
    @IBOutlet weak var left3: UIButton!
    @IBOutlet weak var right1: UIButton!
    @IBOutlet weak var right2: UIButton!
    @IBOutlet weak var right3: UIButton!
    
    
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
        
        
    }
    
    
}

