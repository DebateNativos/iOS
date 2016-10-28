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
    @IBOutlet weak var debateCodeTxtField: UITextField!
    
    var debate: Debate!

    override func viewDidLoad() {
        super.viewDidLoad()

        debateNameLbl.text = debate.name
    }

    @IBAction func studentBtnPressed(_ sender: AnyObject) {
    }
 
    @IBAction func publicBtnPressed(_ sender: AnyObject) {
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
