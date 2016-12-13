//
//  Comment.swift
//  Podium
//
//  Created by Carlos M Solis on 11/1/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

class Comment {

    fileprivate var _name: String!
    fileprivate var _lastName: String!
    fileprivate var _text: String!

    var name: String{
        if _name == nil{
            _name = ""
        }
        return _name
    }

    var lastName: String{
        if _lastName == nil{
            _lastName = ""
        }
        return _lastName
    }

    var text: String{
        if _text == nil{
            _text = ""
        }
        return _text
    }

    init(comment: Dictionary<String, AnyObject>){

        if let temp = comment["user"] as? Dictionary<String, AnyObject> {

            if let name = temp["name"] as? String{
                print("Nombre:  \(name)")
                self._name = name
            }

            if let lastname = temp["lastName"] as? String{
                print("lastname:  \(lastname)")
                self._lastName = lastname
            }

        }

        if let text = comment["text"] as? String{
            print("text:  \(text)")
            self._text = text
        }
    }
    
}
