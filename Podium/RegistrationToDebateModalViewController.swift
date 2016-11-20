//
//  RegistrationToDebateModalViewController.swift
//  Podium
//
//  Created by Jorge Soler on 10/28/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class RegistrationToDebateModalViewController: UIViewController {

    @IBOutlet weak var debateNameLbl: UITextView!
    var debate: Debate!

    override func viewDidLoad() {

        super.viewDidLoad()
        debateNameLbl.text = debate.name

    }

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
