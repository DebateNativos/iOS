//
//  Debate.swift
//  Podium
//
//  Created by Jorge Soler on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class Debate {
    
    var _idDebate: Int
    var _subject: String
    var _date = Date()
    var _time: String
    
    init(){
        
        _idDebate = 0
        _subject = ""
      _date = Date()
        _time = ""
    }
    
    public var id: Int {
        set { _idDebate = id }
        get { return _idDebate }
    }
    
    public var Subject: String {
        set { _subject = Subject }
        get { return _subject }
    }
    
    
    public var DateDeb: Date {
        set { _date = DateDeb }
        get { return _date }
    }
    
    public var Time: String {
        set { _time = Time }
        get { return _time }
    }
    
    
}
