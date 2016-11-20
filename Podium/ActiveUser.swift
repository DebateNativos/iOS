//
//  ActiveUser.swift
//  Podium
//
//  Created by Carlos M Solis on 11/19/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class ActiveUser {

    var _debate: Int!
    var _role: Int!
    var _warning: Int!


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

    }

    public var Debate: Int {
        set { _debate = Debate }
        get { return _debate }
    }

    public var Role: Int {
        set { _role = Role }
        get { return _role }
    }

    public var Warning: Int {
        set { _warning = Warning }
        get { return _warning }
    }
    
}
