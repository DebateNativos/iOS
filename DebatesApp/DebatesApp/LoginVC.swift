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
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func EnterPressed(_ sender: AnyObject) {
   
        let email = tfEmail.text
        let password = tfPassword.text
        
    
    }
    
}

