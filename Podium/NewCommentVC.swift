//
//  NewCommentVC.swift
//  Podium
//
//  Created by Carlos M Solis on 10/31/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import AASquaresLoading

class NewCommentVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textViewComment: UITextView!
    var placeholderLabel : UILabel!
    var id: Int!
    var course: String!
    var debate: Debate!
    var email: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.squareLoading.color = UIColor.red
        textViewDidBeginEditing()
        textViewDidChange(textViewComment)
        textViewComment.becomeFirstResponder()
        //id = debate.idDebates
    }


    func textViewDidBeginEditing(){
        textViewComment.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Escribe tu  comentario..."
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

        self.view.squareLoading.start(0.1)
        
        
        if textViewComment.text.characters.count >= 250 {
            
            SCLAlertView().showError("¡Atención!", subTitle: "El máximo es de 250 caracteres")
            
        }else{
            
            SendComments{}
            
        }
        
        self.view.squareLoading.stop(0.1)

    }

    func SendComments (_ completed: @escaping DownloadComplete){

        let url = "\(BASE_URL)\(PUSH_COMMETNS)\(COURSE)\(course!)\(DEBATE)\(id!)\(EMAILN_RL)\(email!)\(TEXT_COMMENT)\(textViewComment.text!)"

        let COMMENTS_URL = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        Alamofire.request(COMMENTS_URL!).responseString {response in
            let result = response.result

            //DEBUG

            print(response, result, " -> URL: \(COMMENTS_URL)")

            if (result.value) == "@notSent" {

                SCLAlertView().showError("¡Error!", subTitle: "¡Inténtelo más tarde!")

            }else{

                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        completed()
    }
    
}
