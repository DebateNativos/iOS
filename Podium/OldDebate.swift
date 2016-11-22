//
//  OldDebate.swift
//  Podium
//
//  Created by Carlos M Solis on 11/14/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class OldDebate: UIViewController {
    @IBOutlet weak var lblTitle: UITextView!
    var debate: Debate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "\(debate.name)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnBack(_ sender: Any) {

        dismiss(animated: true, completion: nil)
        
    }
    
}
