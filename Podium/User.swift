//
//  User.swift
//  Podium
//
//  Created by Jorge Soler on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class User{
    
    private var _id: Int = 0
    private var _name: String  = ""
    
    
    var id: Int {
        set { _id = id }
        get { return _id }
    }
    
    var name: String {
        set { _name = name }
        get { return _name }
    }
    
    
}
