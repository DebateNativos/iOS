//
//  ProfileVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/13/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

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
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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

    @IBAction func CoursesPressed(_ sender: Any) {

        viewShit()

    }

    func viewShit() {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserData", in: managedObjectContext)

        let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        request.entity = entityDescription

        let pred = NSPredicate(format: "(name = %@)", tfName.text!)
        request.predicate = pred

        do {
            var results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)

            if results.count > 0 {
                let match = results[0] as! NSManagedObject

                tfName.text = match.value(forKey: "name") as? String
                tfLastName.text = match.value(forKey: "lastname") as? String
                tfLastName2.text = match.value(forKey: "lastname2") as? String
                print("Matches found: \(results.count)")
            } else {
                print("No Match")
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
