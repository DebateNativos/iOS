//
//  MenuVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/10/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var debate: Debate!
    var debates = [Debate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DebCell", for: indexPath) as? DebateCell {
            
            let debate = debates[indexPath.row]
            cell.configureCell(debate: debate)
            return cell
        } else {
            return DebateCell()
        }
    }
    
    @IBAction func BackPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
