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

    var courses = [Course]()
    var email:String!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var courseDebate: Course!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewUser()
        getCourses{
        }
        // getCourses{}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)as? CourseCell{
            let course = courses[indexPath.row]
            cell.configureCell(course: course)
            return cell

        } else {
            return CourseCell()
        }
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


    func getCourses(_ completed: @escaping DownloadComplete){

        let MYCOURSES_URL = "\(BASE_URL)\(COURSES_BY_USER)\(EMAIL_URL)\(email!)"
        Alamofire.request(MYCOURSES_URL).responseJSON {response in
            let result = response.result

            print(response, result, "--------URL: \(MYCOURSES_URL)")

            if let dict = result.value as? Dictionary<String, AnyObject>{

                if let course = dict["course"] as? [Dictionary<String, AnyObject>] {

                    print(dict)

                    for obj in dict{
                        
                        //self.courseDebate = Course(course: obj)
                        //self.courses.append(self.courseDebate)
                        self.tableView.reloadData()
                        
                    }
                }
            }
            completed()
        }
    }
    
}
