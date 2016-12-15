//
//  ObserverVC.swift
//  Podium
//
//  Created by Carlos M Solis on 12/12/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import AASquaresLoading

class ObserverVC: UIViewController {
    
    var id: Int!
    var email: String!
    var accessToDebate = [ActiveUser]()
    var debate: Debate!
    var debUser: Bool = false
    var sections = [Section]()
    var activeSection: Section!
    var timerS : Timer?
    var minutesOfUser: Int!
    var minutesOfUser2: Int = 0
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStage: UILabel!
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var lblRedCircle: UILabel!
    @IBOutlet weak var Chronometer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getDebateSection {
            
            self.minutesOfUser2 = self.minutesOfUser
            var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
            
        }
        
        startTimer()
        
        
    }
    
    
    func getDebateSection(_ completed: @escaping DownloadComplete){
        
        let DEBATE_USER_URL = "\(BASE_URL)\(DEBATE_URL)\(IdDEBATE_URL)\(debate.idDebates)"
        
        Alamofire.request(DEBATE_USER_URL).responseJSON {response in
            let result = response.result
            
            print(response, result, "--------URL: \(DEBATE_USER_URL)")
            
            if let dict = result.value as? [Dictionary<String, AnyObject>]{
                
                self.sections.removeAll()
                
                for obj in dict{
                    
                    self.activeSection = Section(Section: obj)
                    self.sections.append(self.activeSection)
                    
                    print("CONTANDO - \(self.sections.count)")
                    
                }
                
                self.UpdateLabels ()
                self.getWarnings()
            }
            completed()
        }
    }
    
    func UserWarn (_ completed: @escaping DownloadComplete) {
        
        let USER_VER_URL = "\(BASE_URL)\(USER_VERIFICATION)\(EMAIL_URL)\(email!)"
        
        Alamofire.request(USER_VER_URL).responseJSON {response in
            let result = response.result
            
            print(response, result, " -> URL: \(USER_VER_URL)")
            
            if let dict = result.value as? [Dictionary<String, AnyObject>]{
                
                self.accessToDebate.removeAll()
                
                for obj in dict{
                    
                    let activeUser = ActiveUser (ActiveUser: obj)
                    self.accessToDebate.append(activeUser)
                    
                }
            }
        }
        
        completed()
        
    }
    
    func UpdateLabels () {
        
        lblName.text = debate.name
        
        if let i = self.sections.index(where: {$0.ActiveSection == true}) {
            
            lblStage.text = self.sections[i].name
            self.minutesOfUser = (self.sections[i].MinutesPerUser)*60
            
        }
    }
    
    func getWarnings(){
        
        let i = self.accessToDebate.index(where: {$0.Debate == debate.idDebates })
        
        let warn = accessToDebate[i!].Warning
        
        if warn>0 {
            
            lblRedCircle.isHidden = false
            lblWarning.isHidden = false
            lblWarning.text = ("\(warn)")
            
            if warn == 3{
                
                dismiss(animated: false, completion: nil)
                stopTimerTest()
                self.performSegue(withIdentifier: "expelled", sender: self )
                
            }
            
        }
        
    }
    
    func startTimer () {
        
        if timerS == nil {
            timerS =  Timer.scheduledTimer(
                timeInterval: TimeInterval(30),
                target      : self,
                selector    : #selector(self.update),
                userInfo    : nil,
                repeats     : true)
        }
    }
    
    func stopTimerTest() {
        
        if timerS != nil {
            timerS?.invalidate()
            timerS = nil
        }
    }
    
    func update () {
        
        getDebateSection{}
        UserWarn{}
        
    }
    
    @IBAction func btnComment(_ sender: Any) {
        
        self.performSegue(withIdentifier: "comment", sender: self )
        
    }
    
    @IBAction func btnStage(_ sender: Any) {
        
        self.performSegue(withIdentifier: "stages", sender: self )
        
    }
    
    @IBAction func btnClose(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        stopTimerTest()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? StagesVC {
            
            destination.id = debate.idDebates
            
            
        }else if let destination = segue.destination as? AskVC {
            
            
            destination.email = email
            destination.id = debate.idDebates
            
        }
        
    }
    
    func updateCounter() {
        
        if self.minutesOfUser2 > 0 {
            let minutes = String(minutesOfUser2 / 60)
            let seconds = String(minutesOfUser2 % 60)
            Chronometer.text = minutes + ":" + seconds
            self.minutesOfUser2 -= 1
            
            if minutesOfUser2 == 29 {
                
                Chronometer.textColor  = UIColor.orange
                
            }else if minutesOfUser2 == 9 {
                
                Chronometer.textColor  = UIColor.red
                
            }
        }
        
    }
    
}
