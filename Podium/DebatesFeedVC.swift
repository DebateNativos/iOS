//
//  MenuVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/10/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import Alamofire

class DebatesFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var debate: Debate!
    var debates = [Debate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getActiveDebates {
            print("hola")
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "debateCell", for: indexPath)as? DebateCell{
            let debate = debates[indexPath.row]
            cell.configureCell(debate: debate)
            return cell
            
        } else {
            return DebateCell()
        }
    }
    
    func getActiveDebates(_ completed: DownloadComplete){
        
        let ACTIVEDEBATES_URL = "\(BASE_URL)\(DEBATES_URL)"
        Alamofire.request(ACTIVEDEBATES_URL).responseJSON {response in
            let result = response.result
            
            print(response, result, "--------URL: \(ACTIVEDEBATES_URL)")
            //DEBUG
            if let dict = result.value as? [Dictionary<String, AnyObject>]{
                
                for obj in dict{
                    
                    let activeDebate = Debate(debate: obj)
                    self.debates.append(activeDebate)
                    print("DEBATE TESTER  \(activeDebate._name)")
                    self.tableView.reloadData()
                }
            }
        }
        completed()
    }
    @IBAction func testbutton(_ sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    @IBAction func BackPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
