//
//  LoginVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/5/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class LoginVC: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var loginStatusLabel: UILabel!
    var loginStatus: String = ""
    var loginUser: User!
    var reach: Reachability!
    var userToEdit: UserData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginUser = User()
        reach = Reachability()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if reach.isInternetAvailable(){
            SCLAlertView().showInfo("Hola!!!", subTitle: "Si hay conexión a internet!")
            
        }else{
            
            SCLAlertView().showWarning("No hay conexión", subTitle: "No se ha logrado establecer conexión a internet.")
        }
        
    }
    
    @IBAction func loginBtnPressed(_ sender: AnyObject) {
        
        self.getLogin{
            if self.loginStatus == "@validLogin"{
                SCLAlertView().showSuccess("LOGIN", subTitle: "Hola \(self.loginUser._name)")
                self.performSegue(withIdentifier: "DebatesFeedVC", sender: self)
                
            }else if self.loginStatus == "@invalidEmail"{
                SCLAlertView().showError("Correo electronico Invalido!", subTitle: "Debe de estar registrado para ingresar a Podium.")
            }else if self.loginStatus == "@invalidPassword"{
                SCLAlertView().showError("Contraseña Invalida!", subTitle: "Trate de nuevo.")
            }
            
        }
        
    }
    
    func getLogin(_ completed: @escaping DownloadComplete){
        
        let LOGIN_USER_URL = "\(BASE_URL)\(LOGIN_URL)\(EMAIL_URL)\(tfEmail.text!)\(PASS_URL)\(tfPassword.text!)"
        
        Alamofire.request(LOGIN_USER_URL).responseJSON {response in
            let result = response.result
            //DEBUG
            print(response, result, "--------URL: \(LOGIN_USER_URL)")
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let status = dict["status"] as? String{
                    if status == "@validLogin"{
                        if let user = dict["user"] as? Dictionary<String, AnyObject>{
                            self.convertJSONtoUser(user: user)
                        }
                        self.loginStatus = status
                    }else{
                        self.loginStatus = status
                    }
                }
            }
            completed()
        }
    }
    func convertJSONtoUser(user: Dictionary<String, AnyObject>){
        
        if let id = user["idUsers"] as? Int{
            self.loginUser._idUsers = id
        }
        if let name = user["name"] as? String{
            self.loginUser._name = name
            print("PRUEBA2 \(name)")
        }
        if let lastName = user["lastName"] as? String{
            self.loginUser._lastName = lastName
        }
        if let lastName2 = user["lastName2"] as? String{
            self.loginUser._lastName2 = lastName2
        }
        if let email = user["email"] as? String{
            self.loginUser._email = email
        }
        if let address = user["address"] as? String{
            self.loginUser._address = address
        }
        if let birthday = user["birthday"] as? String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let birthdayFormatted = dateFormatter.date(from: birthday)
            self.loginUser._birthday = birthdayFormatted!
        }
        if let idUniversity = user["idUniversity"] as? Int{
            self.loginUser._idUniversity = idUniversity
        }
        if let password = user["password"] as? String{
            self.loginUser._password = password
        }
        if let phone = user["phone"] as? String{
            self.loginUser._phone = phone
        }
        if let idToken = user["idToken"] as? String{
            self.loginUser._idToken = idToken
        }
        
    }
    
    func SaveUserInfo(){
        
        
        var user: UserData!
        
        if userToEdit == nil {
            
            user = UserData(context: context)
            
        } else {
            
            user = userToEdit
            
        }
        
        
        if  let nameOfUser: String = loginUser.name {
            
            user.name = nameOfUser
            
        }
        
        
        if  let lastNameOfUser: String = loginUser.lastName {
            
            user.lastname = lastNameOfUser
            
        }
        
        if  let lastName2OfUser: String = loginUser.lastName2 {
            
            user.lastname2 = lastName2OfUser
            
        }
        
        
        if  let email: String = loginUser.email {
            
            user.email = email
            
        }
        
        
        if let address: String = loginUser.address {
            
            user.address = address
            
        }
        
        //
        
        
        if let idUniversity: Int = loginUser.idUniversity{
            
            user.idUniversity = Int64(idUniversity)
            
        }
        
        
        if let phone: String = loginUser.phone{
            
            user.phone = phone
            
        }
        
        if let idToken: String = loginUser.idToken{
            
            user.idToken = idToken
            
        }
        
        ad.saveContext()
        
    }
    
    func SignOut() {
        
        if userToEdit != nil {
            context.delete(userToEdit!)
            ad.saveContext()
        }
        
    }
    
}
