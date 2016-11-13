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

  performSegue(withIdentifier: "DebaterVC", sender: debate)

    }

    @IBAction func publicBtnPressed(_ sender: AnyObject) {

        performSegue(withIdentifier: "ObserverVC", sender: debate)

    }

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ObserverVC"{

            if let destination = segue.destination as? ObserverVC {

                if let debate = sender as? Debate{
                    destination.debate = debate
                }
            }
        }
    }

}
