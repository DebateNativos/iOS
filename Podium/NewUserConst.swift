//
//  NewUserConst.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/16/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit

class NewUserConst {

    var _name: String!
    var _lastName: String!
    var _email: String!
    var _password: String!
    var _code: Int!
    
    var Name: String {
        
        if _name == nil {
            _name = ""
        }
        return _name
    }

    var LastName: String {
        
        if _lastName == nil {
            _lastName = ""
        }
        return _lastName
    }
    
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
    
    var Code: Int {
        
        if _code == nil {
            _code = 0
        }
        return _code
    }
    
}
