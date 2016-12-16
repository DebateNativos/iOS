//
//  ChronometerVC.swift
//  Podium
//
//  Created by Carlos M Solis on 10/18/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import SnapTimer
import Alamofire
import SCLAlertView
import AudioToolbox.AudioServices
import AASquaresLoading

class ChronometerVC: UIViewController {
    
    var timerS : Timer?
    @IBOutlet weak var timer: SnapTimerView!
    @IBOutlet weak var lblDebPart: UILabel!
    @IBOutlet weak var warning: UILabel!
    var debate: Debate!
    var sections = [Section]()
    var activeSection: Section!
    var minutesOfUser: Int!
    @IBOutlet var uiView: UIView!
    var accessToDebate = [ActiveUser]()
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var lblREDCircle: UIImageView!
    var minutesOfUser2: Int = 0
    var email: String!
    var warn: Int!
    var id: Int = 0
    @IBOutlet weak var lblChronometer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.squareLoading.stop(0.0)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        getDebateSection {
            
            self.timer.animateOuterToValue(100, duration: Double(self.minutesOfUser)) {
                
                // self.dismiss(animated: false, completion: nil)
                self.stopTimerTest()
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                self.dismiss(animated: true, completion: nil)
                
            }
            
            self.minutesOfUser2 = self.minutesOfUser
            var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
            
        }
        
        getWarnings()
        startTimer ()
        
    }
    
    
    @IBAction func ClosePressed(_ sender: Any) {
        
        stopTimerTest()
        dismiss(animated: true, completion: nil)
        
    }
    
    func getDebateSection(_ completed: @escaping DownloadComplete){
        
        let DEBATE_USER_URL = "\(BASE_URL)\(DEBATE_URL)\(IdDEBATE_URL)\(debate.idDebates)"
        
        Alamofire.request(DEBATE_USER_URL).responseJSON {response in
            let result = response.result
            
            print(response, result, "--------URL: \(DEBATE_USER_URL)")
            
            if let dict = result.value as? [Dictionary<String, AnyObject>]{
                
                for obj in dict{
                    
                    self.activeSection = Section(Section: obj)
                    self.sections.append(self.activeSection)
                    
                    print("CONTANDO - \(self.sections.count)")
                    
                }
                
                self.UpdateLbls ()
                self.getWarnings()
                self.sections.removeAll()
                
            }
            
            completed()
        }
    }
    
    
    func UpdateLbls () {
        
        if let i = self.sections.index(where: {$0.ActiveSection == true}) {
            
            lblDebPart.text = self.sections[i].name

        }
    }
    
    func VerifyUser (_ completed: @escaping DownloadComplete) {
        
        let USER_VER_URL = "\(BASE_URL)\(USER_VERIFICATION)\(EMAIL_URL)\(email!)"

        print(USER_VER_URL)
        
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
    
    func update () {
        
        VerifyUser{}
        getDebateSection{}
        
    }
    
    func startTimer () {
        
        
        if timerS == nil {
            timerS =  Timer.scheduledTimer(
                timeInterval: TimeInterval(10),
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
    
    func getWarnings(){
        
        let i = self.accessToDebate.index(where: {$0.Debate == debate.idDebates })
        
        let warn = accessToDebate[i!].Warning
        
        let time = accessToDebate[i!].MinutesToTalk
         self.minutesOfUser = (time)*60
        
        if warn>0 {
            
            lblWarning.isHidden = false
            lblREDCircle.isHidden = false
            lblWarning.text = ("\(warn)")
            
            if warn == 3{
                
                //dismiss(animated: false, completion: nil)
                stopTimerTest()
                self.performSegue(withIdentifier: "expelled", sender: self )
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? AdviserVC {
            
            destination.accessToDebate = accessToDebate
            destination.email = email
            destination.debate = debate
            
        }
        
    }
    
    func updateCounter() {
        
        if self.minutesOfUser2 > 0 {
            let minutes = String(minutesOfUser2 / 60)
            let seconds = String(minutesOfUser2 % 60)
            lblChronometer.text = minutes + ":" + seconds
            self.minutesOfUser2 -= 1
            if minutesOfUser2 == 29 {
                
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                lblChronometer.textColor  = UIColor.orange
                
            }else if minutesOfUser2 == 9 {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                lblChronometer.textColor  = UIColor.red
            }else if minutesOfUser2 == 0 {
                
              self.update()
                print("Recargando")
                
            }
        }
        
    }
    
}
