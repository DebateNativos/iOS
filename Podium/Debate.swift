//
//  Debate.swift
//  Podium
//
//  Created by Jorge Soler on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class Debate {

    fileprivate var _idDebates: Int!
    fileprivate var _name: String!
    fileprivate var _debateTypeName: String!
    fileprivate var _debateTypeDescription: String!
    fileprivate var _startingDate: String!


    var idDebates : Int{
        if _idDebates == nil!{
            _idDebates = 0
        }
        return _idDebates
    }

    var name: String{
        if _name == nil!{
            _name = ""
        }
        return _name
    }

    var debateTypeName: String{
        if _debateTypeName == nil!{
            _debateTypeName = ""
        }
        return _debateTypeName
    }

    var startingDate: String{
        if _startingDate == nil!{
            _startingDate = ""
        }
        return _startingDate
    }

    var debateTypeDescription: String{
        if _debateTypeDescription == nil!{
            _debateTypeDescription = ""
        }

        return _debateTypeDescription
    }

    init(){

        _idDebates = 0
        _name = ""
        _debateTypeName = ""
        _debateTypeDescription = ""
        //_startingDate = Date()

    }

    init(debate: Dictionary<String, AnyObject>){

        if let id = debate["idDebates"] as? Int{
            self._idDebates = id
        }

        if let name = debate["name"] as? String{
            print("DEBATE:  \(name)")
            self._name = name
        }

        if let startingDebateDate = debate["startingDate"] as? String{
            print(startingDebateDate)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let myDate = dateFormatter.date(from: startingDebateDate)!

            print("date: \(myDate)")

            let dateFormate = DateFormatter()
            dateFormate.dateStyle = .medium
            let stringOfDate = dateFormate.string(from: myDate)
            print(stringOfDate)

            self._startingDate = stringOfDate
        }

        if let debateType = debate["debateType"] as? Dictionary<String, AnyObject>{

            if let debateType = debateType["name"] as? String{
                self._debateTypeName = debateType
            }
            if let name = debateType["name"] as? String{
                self._debateTypeDescription = name
            }
            
        }
        
        
    }
}
