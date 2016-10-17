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
    @IBOutlet weak var tfVPassword:UITextField!
    @IBOutlet weak var btnCreate: UIButton!
       @IBOutlet weak var tfCode: UITextField!
    var newUserConst = NewUserConst()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCreate.layer.cornerRadius = 3
    }
    
    @IBAction func BackBtnPressed(_ sender: AnyObject) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func CreateAccountPressed(_ sender: AnyObject) {
        
        tfName.text = newUserConst.Name
        tfLastName.text = newUserConst.LastName
        tfEmail.text = newUserConst.Email
        tfPassword.text = newUserConst.Password
       // tfCode.text = newUserConst.Code
        
        
        //METODO
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
