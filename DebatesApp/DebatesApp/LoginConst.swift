//
//  LoginConst.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/16/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit

class LoginConst {
    
    var _email: String!
    var _password:String!
    
    var Email: String {
        
        if _email == nil {
            _email = ""
        }
        return _email
    }
    
    var Password: String {
        
        if _password == nil {
            _password = ""
        }
        return _password
    }
    
}
