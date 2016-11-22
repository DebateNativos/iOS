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
import CoreData

class LoginVC: UIViewController {

    @IBOutlet weak var AutoLogin: UISwitch!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEnter: UIButton!
    @IBOutlet weak var loginStatusLabel: UILabel!
    var loginStatus: String = ""
    var loginUser: User!
    var reach: Reachability!
    var user: UserCoreData!
    var userToEdit: UserCoreData?
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        Autologin()
        reach = Reachability()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if reach.isInternetAvailable(){
            //SCLAlertView().showInfo("!!!", subTitle: "Si hay conexión a internet!")

        }else{

            SCLAlertView().showWarning("No hay conexión", subTitle: "No se ha logrado establecer conexión a internet.")
        }

    }

    @IBAction func loginBtnPressed(_ sender: AnyObject) {

        self.getLogin{
            if self.loginStatus == "@validLogin"{
                SCLAlertView().showSuccess("Bienvenido", subTitle: "Hola \(self.loginUser._name!)")
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

            print(response, result, " -> URL: \(LOGIN_USER_URL)")

            if let dict = result.value as? Dictionary<String, AnyObject>{

                if let status = dict["status"] as? String{
                    if status == "@validLogin"{
                        if let user = dict["user"] as? Dictionary<String, AnyObject>{
                            let userFound = User(user: user)
                            self.loginUser = userFound
                            self.SaveUser(user: self.loginUser)
                            self.tfEmail.text=""
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

    func SaveUser(user: User) {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserData", in: managedObjectContext)

        let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        request.entity = entityDescription

        let pred = NSPredicate(format: "(id = %@)", 0)
        request.predicate = pred

        do {
            let results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)

            if results.count > 0 {

            } else {

                let entityDescription =
                    NSEntityDescription.entity(forEntityName: "UserData", in: managedObjectContext)

                let userD = UserCoreData(entity: entityDescription!, insertInto: managedObjectContext)

                userD.name = user.name
                userD.lastname = user.lastName
                userD.lastname2 = user.lastName2
                userD.id = 0
                userD.email = user.email
                userD.address = user.address
                userD.phone = user.phone
                userD.idToken = user.idToken

                do {
                    try managedObjectContext.save()
                    print("GUARDADO")
                } catch let error {
                    print(error.localizedDescription)
                }

            }

        } catch let error {
            print(error.localizedDescription)
        }

    }


    func Autologin() {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserData", in: managedObjectContext)

        let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        request.entity = entityDescription

        let pred = NSPredicate(format: "(id = %@)", 0)
        request.predicate = pred

        do {
            let results =

                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)

            if results.count > 0 {

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DebatesFeedVC") as! DebatesFeedVC
                self.present(resultViewController, animated:true, completion:nil)

                print("Matches found: \(results.count)")

            } else {

                print("No Match")

            }

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.tfEmail.resignFirstResponder()
        self.tfPassword.resignFirstResponder()
        
    }
    
}
