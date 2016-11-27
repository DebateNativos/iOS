//
//  PublicVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/26/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class PublicVC: UIViewController {

    var debate: Debate!
    @IBOutlet weak var lblDebName: LabelsUI!
    @IBOutlet weak var lblEtapa: LabelsUI!

    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateLabels()
        // Do any additional setup after loading the view.
    }

    func UpdateLabels () {

        lblDebName.text = debate.name
        //lblEtapa.text = debate.debateTypeDescription


    }

    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

    @IBAction func InfoPressed(_ sender: Any) {

        self.performSegue(withIdentifier: "Stages", sender: nil)
        
    }
}
