//
//  MenuTVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/6/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import CoreData

class MenuTVC: UITableViewController {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 5
    }
    @IBAction func LogOutPressed(_ sender: Any) {

        LogOut()

    }

    @IBAction func NewCourse(_ sender: Any) {



    }

    func LogOut() {
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

              //  var deleteUserError: NSError?

                managedObjectContext.delete(match)
                try! managedObjectContext.save()
                print("BORRADO")

                self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                
            } else {
                print("No Match")
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
