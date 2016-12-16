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
import PullToMakeFlight
import AASquaresLoading
import DGElasticPullToRefresh

class DebatesFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var timerS : Timer?
    var debates = [Debate]()
    var debatesVerify = [Debate]()
    var email: String!
    var activeDebate: Debate!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var actualDebate: Debate!
    var accessToDebate = [ActiveUser]()
    let loadingView = DGElasticPullToRefreshLoadingViewCircle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.squareLoading.color = UIColor.red
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
        
        self.view.squareLoading.start(0.1)
        
        self.refreshActiveDebates {
            
            if self.debates.count != self.debatesVerify.count{
                self.tableView.reloadData()
                
            }
        }
        
        loadingView.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            self?.getActiveDebates {
                
                self?.tableView.reloadData()
                
            }
            
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 85/255.0, green: 5/255.0, blue: 0/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    
    
    self.view.squareLoading.stop(0.1)
    
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
        cell.configureCell(debate)
        return cell
        
    } else {
        return DebateCell()
    }
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.view.squareLoading.start(0.0)
    
    let debate = debates[indexPath.row]
    actualDebate = debate
    
    if (debate.timeStatus == "DONE" ) {
        
        print("DebateTerminado")
        performSegue(withIdentifier: "CloseDebate", sender: debate)
        
    } else if (debate.timeStatus == "TODAY") {
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
    
    //self.view.squareLoading.stop(0.0)
    
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let destination = segue.destination as? RegistrationToDebateModalViewController {
        
         destination.debate = actualDebate
        
    }else if let destination = segue.destination as? OldDebate{
        
         destination.debate = actualDebate
        
    }else if let destination = segue.destination as? ChronometerVC{
        
        destination.accessToDebate = accessToDebate
        destination.email = email
    destination.debate = actualDebate
        
    }else if let destination = segue.destination as? AdviserVC{
        
        
        destination.accessToDebate = accessToDebate
        destination.email = email
      destination.debate = actualDebate
        
    }else if let destination = segue.destination as? PublicVC {
        
        destination.debate = actualDebate
        
    }else if let destination = segue.destination as? ObserverVC {
        
        destination.accessToDebate = accessToDebate
        destination.email = email
        destination.debate = actualDebate
        
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
            
            self.debates.removeAll()
            
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
    
    let request: NSFetchRequest<UserCoreData> = UserCoreData.fetchRequest() as! NSFetchRequest<UserCoreData>
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
                    self.accessToDebate.append(activeUser)
                    
                }
                
                let id = self.actualDebate.idDebates
                
                if let i = self.accessToDebate.index(where: {$0.Debate == id }) {
                    
                    // if activeUser.Debate == self.actualDebate.idDebates {
                    if self.accessToDebate[i].Role == 1 {
                        
                        print("Debatiente")
                        self.performSegue(withIdentifier: "Adviser", sender: self )
                        
                    } else if self.accessToDebate[i].Role == 2 {
                        
                        print("Asesor")
                        self.performSegue(withIdentifier: "Adviser", sender: self)
                        
                    } else if self.accessToDebate[i].Role == 3 {
                        
                        print("Observador")
                        self.performSegue(withIdentifier: "Observer", sender: self)
                        
                    } else if self.accessToDebate[i].Role == 4 {
                        
                        print("Publico!")
                        self.performSegue(withIdentifier: "Public", sender: self.actualDebate)
                        
                    } else {
                        
                        print("Error")
                        
                    }
                    
                }else{
                    
                    print("Publico")
                    self.performSegue(withIdentifier: "Public", sender: self.actualDebate)
                    
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
