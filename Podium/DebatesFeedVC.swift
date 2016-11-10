//
//  MenuVC.swift
//  DebatesApp
//
//  Created by Carlos M Solis on 10/10/16.
//  Copyright © 2016 Carlos Solis Corporate. All rights reserved.
//

import UIKit
import Alamofire
import SideMenu

class DebatesFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var debate: Debate!
    var debates = [Debate]()
    var debatesVerify = [Debate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        menu()
        self.getActiveDebates {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.refreshActiveDebates {
            
            if self.debates.count != self.debatesVerify.count{
                self.tableView.reloadData()
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let debate = debates[indexPath.row]
        
        performSegue(withIdentifier: "registrationToDebate", sender: debate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? RegistrationToDebateModalViewController {
            
            if let debate = sender as? Debate{
                destination.debate = debate
            }
        }
        
    }
    
    func getActiveDebates(_ completed: @escaping DownloadComplete){
        
        let ACTIVEDEBATES_URL = "\(BASE_URL)\(DEBATES_URL)"
        Alamofire.request(ACTIVEDEBATES_URL).responseJSON {response in
            let result = response.result
            
            print(response, result, "--------URL: \(ACTIVEDEBATES_URL)")
            //DEBUG
            if let dict = result.value as? [Dictionary<String, AnyObject>]{
                
                for obj in dict{
                    
                    let activeDebate = Debate(debate: obj)
                    self.debates.append(activeDebate)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func refreshActiveDebates(_ completed: @escaping DownloadComplete){
        
        let ACTIVEDEBATES_URL = "\(BASE_URL)\(DEBATES_URL)"
        Alamofire.request(ACTIVEDEBATES_URL).responseJSON {response in
            let result = response.result
            
            print(response, result, "--------URL: \(ACTIVEDEBATES_URL)")
            //DEBUG
            if let dict = result.value as? [Dictionary<String, AnyObject>]{
                
                for obj in dict{
                    
                    let activeDebate = Debate(debate: obj)
                    self.debatesVerify.append(activeDebate)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    
    func menu () {
        
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController()
        menuLeftNavigationController.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        let menuRightNavigationController = UISideMenuNavigationController()
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuRightNavigationController = menuRightNavigationController
        
    }
    
    
    
}
