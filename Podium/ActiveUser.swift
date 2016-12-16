//
//  ActiveUser.swift
//  Podium
//
//  Created by Carlos M Solis on 11/19/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

open class ActiveUser {
    
    fileprivate var _debate: Int!
    fileprivate var _role: Int!
    fileprivate var _warning: Int!
    fileprivate var _course: String!
    fileprivate var _minutesToTalk: Int!
    fileprivate var _isTalking: Bool!
    
    init(ActiveUser: Dictionary<String, AnyObject>) {
        
        if let debate = ActiveUser["debate"] as? Int{
            print("ID \(debate)")
            self._debate = debate
        }
        
        if let role = ActiveUser["role"] as? Int{
            print("ROLE \(role)")
            self._role = role
        }
        
        if let warning = ActiveUser["warning"] as? Int{
            print("Warning \(warning)")
            self._warning = warning
        }
        
        if let course = ActiveUser["team"] as? String{
            print("Course \(course)")
            self._course = course
        }
        
        if let minutesToTalk = ActiveUser["minutesToTalk"] as? Int{
            print("minutesToTalk \(minutesToTalk)")
            self._minutesToTalk = minutesToTalk
        }
        
        if let isTalking = ActiveUser["isTalking"] as? Bool{
            print("isTalking \(isTalking)")
            self._isTalking = isTalking
        }
        
    }
    
    open var Debate: Int {
        set { _debate = Debate }
        get { return _debate }
    }
    
    open var Role: Int {
        set { _role = Role }
        get { return _role }
    }
    
    open var Warning: Int {
        set { _warning = Warning }
        get { return _warning }
    }
    
    open var Course: String {
        set { _course = Course }
        get { return _course }
    }
    
    open var MinutesToTalk: Int {
        set { _minutesToTalk = MinutesToTalk }
        get { return _minutesToTalk }
    }
    
    open var IsTalking: Bool {
        set { _isTalking = IsTalking }
        get { return _isTalking }
    }
    
}
