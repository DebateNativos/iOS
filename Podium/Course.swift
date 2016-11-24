//
//  Course.swift
//  Podium
//
//  Created by Carlos M Solis on 11/23/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class Course {

    fileprivate var _Name: String!
    fileprivate var _Schedule: String!
    fileprivate var _Teacher: String!
    fileprivate var _Class: String!

    var Name: String{
        if _Name == nil{
            _Name = ""
        }
        return _Name
    }

    var Schedule: String{
        if _Schedule == nil{
            _Schedule = ""
        }
        return _Schedule
    }

    var Teacher: String{
        if _Teacher == nil{
            _Teacher = ""
        }
        return _Teacher
    }

    var Class: String{
        if _Class == nil{
            _Class = ""
        }
        return _Class
    }

    init(course: Dictionary<String, AnyObject>) {

        if let name = course["name"] as? String{
            self._Name = name
        }

        if let dClass = course["classroom"] as? String{
            self._Class = dClass
        }

        if let schedule = course["schedule"] as? String{
            self._Schedule = schedule
        }

        if let teacher = course["professor"] as? String{
            self._Teacher = teacher
        }

    }
}
