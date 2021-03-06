//
//  RoundBtn.swift
//  Podium
//
//  Created by Carlos M Solis on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class FieldsUI: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 0.3
        layer.cornerRadius = 2.0
        layer.backgroundColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    func error(_: UITextField){
    
        layer.borderWidth = 0.5
        layer.cornerRadius = 2.0
        layer.backgroundColor = UIColor.red.cgColor
        
    }
    
}
