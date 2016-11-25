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

class ChronometerVC: UIViewController {

    var timerS : Timer?
    @IBOutlet weak var timer: SnapTimerView!
    @IBOutlet weak var lblDebPart: UILabel!
    @IBOutlet weak var warning: UILabel!
    var debate: Debate!

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer ()
    }

    //Primer numero es el % del GUI y el segundo son la cantidad de segundos que va a durar //

    @IBAction func Play(_ sender: AnyObject) {

        self.timer.animateOuterToValue(100, duration: 120) {
            puts("Done!")}

        self.timer.animateInnerToValue(100, duration: 60) {
            puts("Done!")}

    }


    @IBAction func Pause(_ sender: AnyObject) {


        self.timer.pauseAnimation()

    }

    @IBAction func ClosePressed(_ sender: Any) {

        stopTimerTest()
        dismiss(animated: true, completion: nil)

    }

    func getDebateInfo(_ completed: @escaping DownloadComplete){

        let DEBATE_USER_URL = "\(BASE_URL)\(DEBATE_URL)\(IdDEBATE_URL)\(debate.idDebates)"

        Alamofire.request(DEBATE_USER_URL).responseJSON {response in
            let result = response.result

            //DEBUG

            print(response, result, " -> URL: \(DEBATE_USER_URL)")

            if let dict = result.value as? Dictionary<String, AnyObject>{

                if let status = dict["sectionNUmber"] as? Int{

                    if status == 1 {

                        //CODE

                    }

                }
            }
            completed()
        }

    }

    func update () {

        print("Hola")
        getDebateInfo{
        }
    }

    func startTimer () {

        if timerS == nil {
            timerS =  Timer.scheduledTimer(
                timeInterval: TimeInterval(1),
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
    
}
