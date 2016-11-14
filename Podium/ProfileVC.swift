//
//  ProfileVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/13/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController {
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tfName: FieldsUI!
    @IBOutlet weak var tfLastName: FieldsUI!
    @IBOutlet weak var tfLastName2: FieldsUI!
    @IBOutlet weak var tfEmail: FieldsUI!
    @IBOutlet weak var tfPassword: FieldsUI!
    @IBOutlet weak var tfPhone: FieldsUI!
    @IBOutlet weak var tfAddress: FieldsUI!
    @IBOutlet weak var tfidUniversity: FieldsUI!
    var userData: SaveData!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollview.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollview.contentInset = contentInset
    }

    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollview.contentInset = contentInset
    }

    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

    
}
