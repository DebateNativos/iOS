//
//  LoginVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/5/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func EnterPressed(_ sender: AnyObject) {
        
        
        if let email = tfEmail.text, let pwd = tfPassword.text {
            
        }
        
    }
    
}

