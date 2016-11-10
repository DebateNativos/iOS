//
//  NewUserVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/5/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

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
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfidUniversity: FieldsUI!
    var reach: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reach = Reachability()
        
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

    }

    func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
    
    
    func createUser(_ completed: @escaping DownloadComplete){
        
        let NEW_USER_URL = "\(BASE_URL)\(REGISTER_URL)\(NAME_URL)\(tfName.text!)\(LASTNAME_URL)\(tfLastName.text!)\(LASTNAME2_URL)\(tfLastName2.text!)\(EMAILN_RL)\(tfEmail.text!)\(PASSWORD_URL)\(tfPassword.text!)\(PHONE_URL)\(tfPhone.text!)\(ADDRESS_URL)\(tfAddress.text!)\(IDUNIVERSITY_URL)\(tfidUniversity.text!)"
        
        Alamofire.request(NEW_USER_URL).responseJSON {response in
            let result = response.result
            
            print(response, result, " -> URL: \(NEW_USER_URL)")
            
            if (result.value as? Dictionary<String, AnyObject>) != nil{
                
                print("NONE")
                
            }
            
            completed()
        }
    }
    
    @IBAction func createUserPressed(_ sender: Any) {
        if (tfName.text!.isEmpty || tfLastName.text!.isEmpty || tfLastName2.text!.isEmpty || tfEmail.text!.isEmpty || tfPassword.text!.isEmpty || tfVPassword.text!.isEmpty || tfAddress.text!.isEmpty || tfPhone.text!.isEmpty || tfidUniversity.text!.isEmpty) {
            
            SCLAlertView().showError("Campos Requeridos", subTitle: "Todos los campos son requeridos")
            
            tfName.layer.backgroundColor = UIColor.red.cgColor
            tfLastName.layer.backgroundColor = UIColor.red.cgColor
            tfLastName2.layer.backgroundColor = UIColor.red.cgColor
            tfEmail.layer.backgroundColor = UIColor.red.cgColor
            tfPassword.layer.backgroundColor = UIColor.red.cgColor
            tfVPassword.layer.backgroundColor = UIColor.red.cgColor
            tfPhone.layer.backgroundColor = UIColor.red.cgColor
            tfAddress.layer.backgroundColor = UIColor.red.cgColor

            tfidUniversity.layer.backgroundColor = UIColor.red.cgColor
            
        }else{
            
            if (tfPassword.text?.isEqual(tfVPassword.text))! {
                
                self.createUser {
                    
                    //CODIGO
                    
                }
                
            }else{
                
                SCLAlertView().showError("Alerta", subTitle: "Las contraseñas deben coincidir")
                
            }
            
        }
    }
    
}
