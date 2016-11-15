//
//  AboutUsVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/13/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)
        
    }
    
}
