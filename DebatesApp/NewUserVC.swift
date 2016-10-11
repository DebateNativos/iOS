//
//  NewUserVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/5/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit

class NewUserVC: UIViewController {
    
    @IBOutlet weak var StackViewTextField: UIStackView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfVPassword: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func BackBtnPressed(_ sender: AnyObject) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func CreateAccountPressed(_ sender: AnyObject) {
        
        let name = tfName.text
        let lastName = tfLastName.text
        let email = tfEmail.text
        let password = tfPassword.text
        let code = tfCode.text
        
        
        //METODO
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
