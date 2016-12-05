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
    @IBOutlet weak var lblChronometer: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true

        getDebateSection {

            self.timer.animateOuterToValue(100, duration: Double(self.minutesOfUser)) {

                self.stopTimerTest()
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                self.performSegue(withIdentifier: "WaiTurnVC", sender: self.debate.idDebates )

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
                self.sections.removeAll()

            }

            completed()
        }
    }


    func UpdateLbls () {

        if let i = self.sections.index(where: {$0.ActiveSection == true}) {

            lblDebPart.text = self.sections[i].name

            self.minutesOfUser = (self.sections[i].MinutesPerUser)*60


        }
    }

    func update () {

        print("Hola")
        getDebateSection{}

        //        if (EL MAE NO ESTA HABLANDO){
        //
        //          stopTimerTest()
        //          self.performSegue(withIdentifier: "WaiTurnVC", sender: self.actualDebate)
        //
        //        }else{
        //
        //
        //        }
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

    func getWarnings(){

        let i = self.accessToDebate.index(where: {$0.Debate == debate.idDebates })

        let warn = accessToDebate[i!].Warning

        if warn>0 {

            lblWarning.isHidden = false
            lblREDCircle.isHidden = false
            lblWarning.text = ("\(warn)")

        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? WaiTurnVC {
            
            if let idDebate = sender as? Int{
                destination.id = idDebate
            }
        }
        
    }
    
    func updateCounter() {
        //you code, this is an example
        if self.minutesOfUser2 > 0 {
            lblChronometer.text = "\(self.minutesOfUser2)"
            self.minutesOfUser2 -= 1
        }
        
    }
    
}
