//
//  ProtocolVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/13/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class ProtocolVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func BackPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)

    }



}
