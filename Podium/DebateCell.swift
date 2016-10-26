//
//  LabelsUI.swift
//  Podium
//
//  Created by Carlos M Solis on 10/19/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class LabelsUI: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 3.0
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor( red: 15/255, green: 127/255, blue:65/255, alpha: 1.0 ).cgColor
        
        
    }
}
