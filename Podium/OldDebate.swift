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


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    @IBAction func btnBack(_ sender: Any) {

        dismiss(animated: true, completion: nil)
        
    }
    
}
