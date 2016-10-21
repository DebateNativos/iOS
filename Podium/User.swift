//
//  User.swift
//  Podium
//
//  Created by Jorge Soler on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class User{
    
    private var _idUsers: Int
    private var _name: String
    private var _lastName: String
    private var _lastName2: String
    private var _email: String
    private var _address: String
    private var _birthday = Date()
    private var _idUniversity: Int
    private var _password: String
    private var _phone: String
    private var _idToken: String
    
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
    
    func fillUserFromJson(userDict: Dictionary<String, AnyObject>) -> User{
        
        if let id = userDict["idUsers"] as? Int{
            self._idUsers = id
        }
        if let name = userDict["name"] as? String{
            self._name = name
        }
        if let lastName = userDict["lastName"] as? String{
            self._lastName = lastName
        }
        if let lastName2 = userDict["lastName2"] as? String{
            self._lastName2 = lastName2
        }
        if let email = userDict["email"] as? String{
            self._email = email
        }
        if let address = userDict["address"] as? String{
            self._address = address
        }
        if let birthday = userDict["birthday"] as? String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let birthdayFormatted = dateFormatter.date(from: birthday)
            self._birthday = birthdayFormatted!
        }
        if let idUniversity = userDict["idUniversity"] as? Int{
            self._idUniversity = idUniversity
        }
        if let password = userDict["password"] as? String{
            self._password = password
        }
        if let phone = userDict["phone"] as? String{
            self._phone = phone
        }
        if let idToken = userDict["idToken"] as? String{
            self._idToken = idToken
        }
        return self
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
