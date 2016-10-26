//
//  User.swift
//  Podium
//
//  Created by Jorge Soler on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class User {
    
    var _idUsers: Int
    var _name: String
    var _lastName: String
    var _lastName2: String
    var _email: String
    var _address: String
    var _birthday = Date()
    var _idUniversity: Int
    var _password: String
    var _phone: String
    var _idToken: String
    
    init(){
        _idUsers = 0
        _name = ""
        _lastName = ""
        _lastName2 = ""
        _email = ""
        _address = ""
        _birthday = Date()
        _idUniversity = 0
        _password = ""
        _phone = ""
        _idToken = ""
    }
    
    
    public var id: Int {
        set { _idUsers = id }
        get { return _idUsers }
    }
    
    public var name: String {
        set { _name = name }
        get { return _name }
    }
    public var lastName: String {
        set { _lastName = lastName }
        get { return _lastName }
    }
    
    public var lastName2: String {
        set { _lastName2 = lastName2 }
        get { return _lastName2 }
    }
    
    public var email: String {
        set { _email = email }
        get { return _email }
    }
    
    public var address: String {
        set { _address = address }
        get { return _address }
    }
    
    public var birthday: Date {
        set { _birthday = birthday }
        get { return _birthday }
    }
    
    public var idUniversity: Int {
        set { _idUniversity = idUniversity }
        get { return _idUniversity }
    }
    
    public var password: String {
        set { _password = password }
        get { return _password }
    }
    
    public var phone: String {
        set { _phone = phone }
        get { return _phone }
    }
    
    public var idToken: String {
        set { _idToken = idToken }
        get { return _idToken }
    }
    
    
    
    
    
}
