//
//  AskVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/26/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import CoreData
import AASquaresLoading

class AskVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textViewComment: UITextView!
    var placeholderLabel : UILabel!
    var id: Int!
    var email: String!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.squareLoading.color = UIColor.red
        textViewDidBeginEditing()
        textViewDidChange(textViewComment)
        textViewComment.becomeFirstResponder()
        viewUser()
        // Do any additional setup after loading the view.
    }
    
    
    func textViewDidBeginEditing(){
        textViewComment.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Escribe tu pregunta..."
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
        
         self.view.squareLoading.start(1.0)
        
        if textViewComment.text.characters.count >= 250 {
         
            SCLAlertView().showError("¡Atención!", subTitle: "El máximo es de 250 caracteres")
        
        }else{
        
            SendQuestion{}
        
        }
    
         self.view.squareLoading.stop(1.0)
        
    }
    
    func SendQuestion (_ completed: @escaping DownloadComplete){
        
        let url = "\(BASE_URL)\(PUSH_QUESTION)\(DEBATE2)\(id!)\(EMAILN_RL)\(email!)\(TEXT_COMMENT)\(textViewComment.text!)"
        
        let COMMENTS_URL = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(COMMENTS_URL!).responseString {response in
            let result = response.result
            
            print(response, result, " -> URL: \(COMMENTS_URL)")
            
            if (result.value) == "question@notSent" {
                
                SCLAlertView().showError("¡Error!", subTitle: "¡Inténtelo más tarde!")
                
            }else{
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        completed()
    }
    
    func viewUser() {
        
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserData", in: managedObjectContext)
        
        let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest() as! NSFetchRequest<UserCoreData>
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(id = %@)", 0)
        request.predicate = pred
        
        do {
            var results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                email = match.value(forKey: "email") as? String
                
                print("Matches found: \(results.count)")
                
            } else {
                print("No Match")
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
