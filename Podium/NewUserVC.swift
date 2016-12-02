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
import AudioToolbox
import AASquaresLoading

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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfidUniversity: FieldsUI!
    var reach: Reachability!

    override func viewDidLoad() {
        super.viewDidLoad()
        reach = Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.scrollView.contentSize = CGSize(width:1, height:self.scrollView.frame.size.height * 9)
    }

    @IBAction func BackBtnPressed(sender: AnyObject) {

        dismiss(animated: true, completion: nil)

    }


    func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view so it doesn't cover up anything the user needs to tap

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

        let url = "\(BASE_URL)\(REGISTER_URL)\(NAME_URL)\(tfName.text!)\(LASTNAME_URL)\(tfLastName.text!)\(LASTNAME2_URL)\(tfLastName2.text!)\(EMAILN_RL)\(tfEmail.text!)\(PASSWORD_URL)\(tfPassword.text!)\(PHONE_URL)\(tfPhone.text!)\(ADDRESS_URL)\(tfAddress.text!)\(IDUNIVERSITY_URL)\(tfidUniversity.text!)"

        let NEW_USER_URL = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        Alamofire.request(NEW_USER_URL!).responseString {response in
            let result = response.result

            print(response, result, " -> URL: \(NEW_USER_URL)")

            if (result.description) == "@invalidRegistration" {

                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                SCLAlertView().showError("Ops!", subTitle: "Ocurrió un error, inténtalo de nuevo más tarde")

            }else{

                self.view.squareLoading.stop(0.0)
                SCLAlertView().showSuccess("Exito!", subTitle: "Se creo su perfil de manera correcta")
                self.dismiss(animated: true, completion: nil)

            }

            completed()
        }
    }


    @IBAction func btnCreatePressed(_ sender: Any) {

        self.view.squareLoading.start(1.0)

        if (tfName.text!.isEmpty || tfLastName.text!.isEmpty || tfLastName2.text!.isEmpty || tfEmail.text!.isEmpty || tfPassword.text!.isEmpty || tfVPassword.text!.isEmpty || tfAddress.text!.isEmpty || tfPhone.text!.isEmpty || tfidUniversity.text!.isEmpty) {

            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
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

            self.view.squareLoading.stop(0.0)

        }else{

            if isValidEmail(testStr: tfEmail.text!){

                if (tfPassword.text?.isEqual(tfVPassword.text))! {

                    self.createUser{}

                }else{

                    self.view.squareLoading.stop(0.0)
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    SCLAlertView().showError("Alerta", subTitle: "Las contraseñas deben coincidir")

                }

            }
            else{

                self.view.squareLoading.stop(0.0)
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                SCLAlertView().showError("Alerta", subTitle: "No es un email valido")
            }

        }



    }

    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.tfName.resignFirstResponder()
        self.tfLastName.resignFirstResponder()
        self.tfLastName2.resignFirstResponder()
        self.tfEmail.resignFirstResponder()
        self.tfPassword.resignFirstResponder()
        self.tfVPassword.resignFirstResponder()
        self.tfPhone.resignFirstResponder()
        self.tfAddress.resignFirstResponder()
        self.tfidUniversity.resignFirstResponder()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
