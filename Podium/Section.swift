//
//  Section.swift
//  Podium
//
//  Created by Carlos M Solis on 11/27/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import Foundation

public class Section {

    var _sectionNUmber: Int!
    var _minutesPerUser: Int!
    var _activeSection: Bool!
    var _name: String!

    init(Section: Dictionary<String, AnyObject>) {

        if let SNumb = Section["sectionNUmber"] as? Int{
            self._sectionNUmber = SNumb
        }
        if let minutesPerUser = Section["minutesPerUser"] as? Int{
            self._minutesPerUser = minutesPerUser

        }
        if let activeSection = Section["activeSection"] as? Bool{
            self._activeSection = activeSection
        }
        if let name = Section["name"] as? String{
            self._name = name
        }

    }


    public var SectionNumber: Int {
        set { _sectionNUmber = SectionNumber }
        get { return _sectionNUmber }
    }

    public var MinutesPerUser: Int {
        set { _minutesPerUser = MinutesPerUser }
        get { return _minutesPerUser }
    }
    public var ActiveSection: Bool {
        set { _activeSection = ActiveSection }
        get { return _activeSection }
    }

    public var name: String {
        set { _name = name }
        get { return _name }
    }
    
}
