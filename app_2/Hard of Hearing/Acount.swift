//
//  Acount.swift
//  Hard of Hearing
//
//  Created by 苏 on 2019/1/13.
//  Copyright © 2019 StarterHack. All rights reserved.
//

import UIKit

class Acount: UIViewController {

    @IBAction func settingButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "segue_setting", sender: self)
    }
    
    
    

    @IBAction func unwind(for segue: UIStoryboardSegue) {
    print("unwind...")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
