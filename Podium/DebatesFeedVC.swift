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
import CoreData

class DebatesFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var timerS : Timer?
    var debates = [Debate]()
    var debatesVerify = [Debate]()
    var email: String!
    var activeDebate: Debate!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var actUsr: ActiveUser!
    var id: Int!
    var actualDebate: Debate!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        menu()
        viewUser()
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
        actualDebate = debate

        if (debate.timeStatus == "DONE" ) {
            print("DebateTerminado")
            performSegue(withIdentifier: "CloseDebate", sender: debate)

        } else if (debate.timeStatus == "TODAY" ){
            if debate.Status == true {

                VerifyUser () {

                }

            }else {
                print("Debate inactivo")
                performSegue(withIdentifier: "InactiveDebate", sender: debate)

            }
        } else {

            print("Debate inactivo")
            performSegue(withIdentifier: "InactiveDebate", sender: debate)

        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? RegistrationToDebateModalViewController {

            if let debate = sender as? Debate{
                destination.debate = debate
            }
        }else if let destination = segue.destination as? OldDebate{

            if let debate = sender as? Debate{
                destination.debate = debate
            }

        }else if let destination = segue.destination as? ChronometerVC{

            if let debate = sender as? Debate{
                destination.debate = debate
            }

        }else if let destination = segue.destination as? ObserverVC{

            if let debate = sender as? Debate{
                destination.debate = debate
            }

        }else if let destination = segue.destination as? PublicVC {

            if let debate = sender as? Debate{
                destination.debate = debate
            }

        }

    }

    func startTimer () {

        if timerS == nil {
            timerS =  Timer.scheduledTimer(
                timeInterval: TimeInterval(3600),
                target      : self,
                selector    : #selector(self.update),
                userInfo    : nil,
                repeats     : true)
        }
    }

    func update () {

        print("REFRESH")
        refreshActiveDebates{}

    }

    func stopTimerTest() {
        if timerS != nil {
            timerS?.invalidate()
            timerS = nil
        }
    }

    func getActiveDebates(_ completed: @escaping DownloadComplete){

        let ACTIVEDEBATES_URL = "\(BASE_URL)\(DEBATES_URL)"
        Alamofire.request(ACTIVEDEBATES_URL).responseJSON {response in
            let result = response.result

            print(response, result, "--------URL: \(ACTIVEDEBATES_URL)")

            if let dict = result.value as? [Dictionary<String, AnyObject>]{

                for obj in dict{

                    self.activeDebate = Debate(debate: obj)
                    self.debates.append(self.activeDebate)
                    self.tableView.reloadData()
                    self.startTimer()
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

                self.email = (match.value(forKey: "email") as? String)!

                print("Matches found: \(results.count)")

            } else {
                print("No Match")
            }

        } catch let error {
            print(error.localizedDescription)
        }

    }

    func VerifyUser (_ completed: @escaping DownloadComplete) {

        let USER_VER_URL = "\(BASE_URL)\(USER_VERIFICATION)\(EMAIL_URL)\(email!)"

        Alamofire.request(USER_VER_URL).responseJSON {response in
            let result = response.result

            print(response, result, " -> URL: \(USER_VER_URL)")

            if let dict = result.value as? [Dictionary<String, AnyObject>]{

                if dict.isEmpty{

                    print("Publico sin registrar")
                    self.performSegue(withIdentifier: "Public", sender: self.actualDebate)

                }else{

                    for obj in dict{

                        let activeUser = ActiveUser (ActiveUser: obj)

                        if activeUser.Debate == self.actualDebate.idDebates {

                            if activeUser.Role == 1 {

                                print("Debatiente")
                                self.performSegue(withIdentifier: "Debating", sender: self.actualDebate )

                            } else if activeUser.Role == 2 {

                                print("Asesor")
                                self.performSegue(withIdentifier: "Observer", sender: self.actualDebate)

                            } else if activeUser.Role == 3 {

                                print("Observador")
                                self.performSegue(withIdentifier: "Observer", sender: self.actualDebate)

                            } else {

                                print("REVISAR!")
                                self.performSegue(withIdentifier: "Observer", sender: self.actualDebate)

                            }


                        }else{
                            
                            print("Publico")
                            self.performSegue(withIdentifier: "Public", sender: self.actualDebate)
                            
                        }
                    }
                }
            }
        }
        completed()
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
