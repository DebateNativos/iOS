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
    fileprivate var _timeStatus: String!
    fileprivate var _status: Bool!


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

    var timeStatus: String{
        if _timeStatus == nil!{
            _timeStatus = ""
        }

        return _timeStatus
    }

    var Status: Bool{
        if _status == nil!{
            _status = false
        }

        return _status
    }

    init(){

        _idDebates = 0
        _name = ""
        _debateTypeName = ""
        _debateTypeDescription = ""
        //_startingDate = Date()
        _timeStatus=""
        _status=false

    }

    init(debate: Dictionary<String, AnyObject>){

        if let id = debate["idDebates"] as? Int{
            self._idDebates = id
        }

        if let name = debate["name"] as? String{
            print("Nombre:  \(name)")
            self._name = name
        }

        if let startingDebateDate = debate["startingDate"] as? CLong{
            print("Fecha: \(startingDebateDate)")

            let date = Date()

            let dateTimeStamp = NSDate(timeIntervalSince1970:Double(startingDebateDate)/1000)  //UTC time

            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.local //Edit
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.dateStyle = DateFormatter.Style.medium
            //dateFormatter.timeStyle = DateFormatter.Style.short


            let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)
            print(strDateSelect) //Local time

            let dateFormatter2 = DateFormatter()
            dateFormatter2.timeZone = NSTimeZone.local
            dateFormatter2.dateFormat = "yyyy-MM-dd"

            let myDate = dateFormatter.date(from: strDateSelect)

            self._startingDate = strDateSelect

            print("Fecha: \(myDate)")

            switch myDate!.compare(date as Date) {
            case .orderedAscending     :
                print("Date A is earlier than date B")
                self._timeStatus = "DONE"

            case .orderedDescending    :
                print("Date A is later than date B")
                self._timeStatus = "SOON"
            case .orderedSame          :
                print("The two dates are the same")
                self._timeStatus = "TODAY"
                print(date)


            }

            if let debateType = debate["debateType"] as? String{
                self._debateTypeName = debateType
                print("Modelo:  \(_debateTypeName)")
            }
            
            if let debateType = debate["isActive"] as? Bool{
                self._status = debateType
                print("Active?:  \(_status)")
            }
            
        }
    }
    
}
