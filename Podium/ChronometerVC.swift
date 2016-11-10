//
//  ChronometerVC.swift
//  Podium
//
//  Created by Carlos M Solis on 10/18/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import SnapTimer

class ChronometerVC: UIViewController {
    
    @IBOutlet weak var timer: SnapTimerView!
    @IBOutlet weak var lblDebPart: UILabel!
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    //Primer numero es el % del GUI y el segundo son la cantidad de segundos que va a durar //
    
    @IBAction func Play(_ sender: AnyObject) {
        
        self.timer.animateOuterToValue(100, duration: 120) {
            puts("Done!")}
        
        self.timer.animateInnerToValue(100, duration: 60) {
            puts("Done!")}
        
    }
    
    
    @IBAction func Pause(_ sender: AnyObject) {
        
        self.timer.pauseAnimation()
        
    }
    
}
