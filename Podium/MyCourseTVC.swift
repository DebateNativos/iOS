//
//  MyCourseTVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/21/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class MyCourseTVC: UITableViewController {

    var email:String!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        viewUser()
       // getCourses{}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func BacKPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)

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


//    func getCourses(_ completed: @escaping DownloadComplete){
//
//        let MYCOURSES_URL = "\(BASE_URL)\(COURSES_BY_USER)\(EMAIL_URL)\(email!)"
//        Alamofire.request(MYCOURSES_URL).responseJSON {response in
//            let result = response.result
//
//            print(response, result, "--------URL: \(MYCOURSES_URL)")
//
//            if let dict = result.value as? Dictionary<String, AnyObject>{
//
//                if let course = dict["course"] as? Dictionary<String, AnyObject>{
//
//                    for obj in dict{
//
//                        let myCourse = Course(course: obj)
//                        self.tableView.reloadData()
//                    }
//                }
//                
//                
//            }
//            completed()
//        }
//    }
}

//COURSES_BY_USER/EMAIL_URL
