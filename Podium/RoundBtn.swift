//
//  RoundBtn.swift
//  Podium
//
//  Created by Carlos M Solis on 10/16/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        layer.cornerRadius = 3;
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit
    }

}
