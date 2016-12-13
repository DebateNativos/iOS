//
//  AskVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/26/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class AskVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textViewComment: UITextView!
    var placeholderLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        textViewDidBeginEditing()
        textViewDidChange(textViewComment)
        textViewComment.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }


    func textViewDidBeginEditing(){
        textViewComment.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Escribe tu pregunta ..."
        placeholderLabel.sizeToFit()
        textViewComment.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textViewComment.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.isHidden = !textViewComment.text.isEmpty

        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.barTintColor = UIColor.white

        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(btnDone))
        addButton.tintColor = UIColor.black
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let spaceButtonTwo = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolbar.items = [spaceButton, spaceButtonTwo, addButton]
        textViewComment.inputAccessoryView = keyboardToolbar

    }

    func textViewDidChange(_ textView: UITextView) {

        placeholderLabel.isHidden = !textView.text.isEmpty

    }

    @IBAction func closePressed(_ sender: AnyObject) {

        dismiss(animated: true, completion: nil)
        
    }
    func btnDone(){
        
        //Code
        
    }
    
}
