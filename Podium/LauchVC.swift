//
//  LauchVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/17/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import CoreData

class LauchVC: UINavigationController {

let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func Autologin() {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserData", in: managedObjectContext)

        let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest()
        request.entity = entityDescription

        let pred = NSPredicate(format: "(id = %@)", 0)
        request.predicate = pred

        do {
            let results =

                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)

            if results.count > 0 {

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DebatesFeedVC") as! DebatesFeedVC
                self.present(resultViewController, animated:true, completion:nil)

                print("Matches found: \(results.count)")

            } else {

                print("No Match")

            }

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
