//
//  NewCourseVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/19/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SCLAlertView
import AudioToolbox.AudioServices

class NewCourseVC: UIViewController {

    @IBOutlet weak var tfCode: UITextField!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var email: String!
    var code: String!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfCode.becomeFirstResponder()
        viewUser()
        // Do any additional setup after loading the view.
    }

    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }
    @IBAction func ReturnKey(_ sender: Any) {

        if (tfCode.text?.isEmpty)! {

            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            SCLAlertView().showError("Error", subTitle: "Debe ingresar un codigo")

        }else{

            NewCourse {

            }
        }
    }

    func viewUser() {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserData", in: managedObjectContext)

        let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
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

    func NewCourse(_ completed: @escaping DownloadComplete){

        let NEW_COURSE_URL = "\(BASE_URL)\(ADD_COURSE)\(EMAIL_URL)\("\(email!)")\(COURSE_CODE)\(tfCode.text!)"

        Alamofire.request(NEW_COURSE_URL).responseJSON {response in
            let result = response.result

            print(response, result, " -> URL: \(NEW_COURSE_URL)")

            if let dict = result.value as? Dictionary<String, AnyObject>{

                if let status = dict["status"] as? String{
                    if status == "@validRegistration"{

                        self.code = self.tfCode.text

                        self.performSegue(withIdentifier: "Course", sender: self.code)

                        print("S Happens")

                    }else if status == "@courseAlreadyRegistrated" {

                        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                        SCLAlertView().showError("Error", subTitle: "Usted ya matriculo este curso")
                        print("S NOT Happens")

                    } else {

                        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                        SCLAlertView().showError("Error", subTitle: "El curso ingresado no existe")
                        print("S NOT Happens NOP")

                    }
                }
            }else{

                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                SCLAlertView().showError("Error", subTitle: "Ha ocurrido un error, por favor intente de nuevo más tarde.")
                print("S NOT Happens (IMPORTANT)")
                
            }
        }
        completed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? CourseVC {
            
            if let course = sender as? String{
                destination.courseCode = course
            }
        }
        
    }
    
}
