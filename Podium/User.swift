//
//  User.swift
//  Podium
//
//  Created by Jorge Soler on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation
import CoreData

public class User {

    var _idUsers: Int!
    var _name: String!
    var _lastName: String!
    var _lastName2: String!
    var _email: String!
    var _address: String!
    var _birthday: Date!
    var _idUniversity: Int!
    var _password: String!
    var _phone: String!
    var _idToken: String!
    
    
    init(user: Dictionary<String, AnyObject>) {
        
        if let id = user["idUsers"] as? Int{
        self._idUsers = id
        }
        if let name = user["name"] as? String{
        self._name = name
        print("PRUEBA2 \(name)")
        }
        if let lastName = user["lastName"] as? String{
        self._lastName = lastName
        }
        if let lastName2 = user["lastName2"] as? String{
        self._lastName2 = lastName2
        }
        if let email = user["email"] as? String{
        self._email = email
        }
        if let address = user["address"] as? String{
        self._address = address
        }
        if let birthday = user["birthday"] as? String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthdayFormatted = dateFormatter.date(from: birthday)
        self._birthday = birthdayFormatted!
        }
        if let idUniversity = user["idUniversity"] as? Int{
        self._idUniversity = idUniversity
        }
        if let password = user["password"] as? String{
        self._password = password
        }
        if let phone = user["phone"] as? String{
        self._phone = phone
        }
        if let idToken = user["idToken"] as? String{
        self._idToken = idToken
        }
        
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
