//
//  NewCourseVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/19/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class NewCourseVC: UIViewController {

    @IBOutlet weak var tfCode: RoundBtn!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfCode.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)
        
    }
    
}
