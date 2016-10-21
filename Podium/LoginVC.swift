//
//  LoginVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/5/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var loginStatusLabel: UILabel!
    var loginUser: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginUser = User()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func loginBtnPressed(_ sender: AnyObject) {
        self.getLogin{
            print("USERNAME ---- \(self.loginUser.name)")
        }
    }
    
    func getLogin(_ completed: DownloadComplete){
        //De donde se bajan los datos.
        //Info.plist agregar app transport security settings -> Allow Arbitrary Loads = YES si no es HTTPS
        let LOGIN_USER_URL = "\(BASE_URL)\(LOGIN_URL)\(EMAIL_URL)\(tfEmail.text!)\(PASS_URL)\(tfPassword.text!)"
        
        Alamofire.request(LOGIN_USER_URL).responseJSON {response in
            let result = response.result
            //DEBUG
            print(response, result, "--------URL: \(LOGIN_USER_URL)")
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let status = dict["status"] as? String{
                    if status == "@validLogin"{
                        //self.loginStatusLabel.text = status
                        if let user = dict["user"] as? Dictionary<String, AnyObject>{
                            if let id = user["idUsers"] as? Int{
                                self.loginUser.id = id
                            }
                            if let name = user["name"] as? String{
                                self.loginUser.name = name
                            }
                            if let lastName = user["lastName"] as? String{
                                self.loginUser.lastName = lastName
                            }
                            if let lastName2 = user["lastName2"] as? String{
                                self.loginUser.lastName2 = lastName2
                            }
                            if let email = user["email"] as? String{
                                self.loginUser.email = email
                            }
                            if let address = user["address"] as? String{
                                self.loginUser.address = address
                            }
                            if let birthday = user["birthday"] as? String{
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                let birthdayFormatted = dateFormatter.date(from: birthday)
                                self.loginUser.birthday = birthdayFormatted!
                            }
                            if let idUniversity = user["idUniversity"] as? Int{
                                self.loginUser.idUniversity = idUniversity
                            }
                            if let password = user["password"] as? String{
                                self.loginUser.password = password
                            }
                            if let phone = user["phone"] as? String{
                                self.loginUser.phone = phone
                            }
                            if let idToken = user["idToken"] as? String{
                                self.loginUser.idToken = idToken
                            }
                        }else if status == "@invalidEmail"{
                            self.loginStatusLabel.text = "Correo electronico invalido."
                        }else if status == "@invalidPassword"{
                            self.loginStatusLabel.text = "Contrasena invalida."
                        }
                    }
                }
                
            }
            
        }
        completed()
    }
}
