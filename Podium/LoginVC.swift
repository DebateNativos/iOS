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
    
    var user1: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user1 = User()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
}

//    @IBAction func EnterPressed(_ sender: AnyObject) {
//
//
//        if let email = tfEmail.text, let pwd = tfPassword.text {
//
//        }
//
//    }

func getUserDetails(_ completed: DownloadComplete){
    //De donde se bajan los datos.
    //Info.plist agregar app transport security settings -> Allow Arbitrary Loads = YES si no es HTTPS
    
    Alamofire.request(BASE_URL).responseJSON {response in
        let result = response.result
        //DEBUG
        print(response, result, "--------URL: \(BASE_URL)")
        
        if let dict = result.value as? [Dictionary<String, AnyObject>]{
            
            if let id = dict[1]["id"] as? Int{
                // self.label1.text = "\(id)"
                //print("ID \(self.user1.id) ++++ \(id)")
            }
            
            if let name = dict[1]["nombre"] as? String{
                // self.label2.text = name.capitalized
                //print("NAMEEE \(self.user1.name) ++++ \(name)")
            }
            
        }
    }
    completed()
}




