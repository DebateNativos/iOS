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
        return 4
    }
    @IBAction func LogOutPressed(_ sender: Any) {
        // let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //   let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedObjectContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedObjectContext.delete(managedObjectData)
                print("Borrado")

                self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)

            }
        } catch let error as NSError {
            print("Detele all data in UserData error : \(error) \(error.userInfo)")
        }
    }
}
