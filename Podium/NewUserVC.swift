//
//  NewUserVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/5/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import Alamofire

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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfidUniversity: FieldsUI!
    var reach: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarPicker()
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
        
        datePickerView.addTarget(self, action: #selector(NewUserVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "M-d-YYYY" //DateFormatter.Style.short
        
        tfBirthday.text = dateFormatter.string(from: sender.date)
        
        
    }
    
    
    func navBarPicker(){
        
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        
        pickerView.backgroundColor = .white
        pickerView.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(NewUserVC.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        // let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("canclePicker")))
        
        toolBar.setItems([/*cancelButton,*/ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        tfBirthday.inputView = pickerView
        tfBirthday.inputAccessoryView = toolBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func donePicker(){
        
        tfBirthday.resignFirstResponder()
        
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
        
        let NEW_USER_URL = "\(BASE_URL)\(REGISTER_URL)\(NAME_URL)\(tfName.text!)\(LASTNAME_URL)\(tfLastName.text!)\(LASTNAME2_URL)\(tfLastName2.text!)\(EMAILN_RL)\(tfEmail.text!)\(PASSWORD_URL)\(tfPassword.text!)\(PHONE_URL)\(tfPhone.text!)\(BIRTHDAY_URL)\(tfBirthday.text!)\(ADDRESS_URL)\(tfAddress.text!)\(IDUNIVERSITY_URL)\(tfidUniversity.text!)"
        
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
        
        self.createUser {
            //CODIGO
        }
        
    }
    
}
