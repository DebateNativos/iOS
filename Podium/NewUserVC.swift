//
//  NewUserVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/5/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit

class NewUserVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var StackViewTextField: UIStackView!
    @IBOutlet weak var tfName: FieldsUI!
    @IBOutlet weak var tfLastName: FieldsUI!
    @IBOutlet weak var tfLastName2: FieldsUI!
    @IBOutlet weak var tfEmail: FieldsUI!
    @IBOutlet weak var tfPassword: FieldsUI!
    @IBOutlet weak var tfVPassword: FieldsUI!
    @IBOutlet weak var tfPhone: FieldsUI!
    @IBOutlet weak var tfAddress: FieldsUI!
    @IBOutlet weak var tfBirthday: FieldsUI!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var btnDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.tfEmail.delegate = self
    }
    
    @IBAction func BackBtnPressed(sender: AnyObject) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func CreateAccountPressed(_ sender: AnyObject) {
        
        //METODO
        
    }
    
    
    @IBAction func tfEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(NewUserVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        tfBirthday.text = dateFormatter.string(from: sender.date)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
}
