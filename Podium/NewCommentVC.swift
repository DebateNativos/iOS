//
//  NewCommentVC.swift
//  Podium
//
//  Created by Carlos M Solis on 10/31/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class NewCommentVC: UIViewController {
    
    @IBOutlet weak var textViewComment: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewDidBeginEditing()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing() {
        if textViewComment.textColor == UIColor.lightGray {
            textViewComment.text = nil
            textViewComment.textColor = UIColor.black
        }
    }
    
}
