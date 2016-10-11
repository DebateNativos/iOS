//
//  PasswordLostVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/9/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit

class PasswordLostVC: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func SendEmailPressed(_ sender: AnyObject) {
        
        let email = tfEmail.text
        
        //Metodo para enviar email
        dismiss(animated: true, completion: nil)
        
    }
    
}
