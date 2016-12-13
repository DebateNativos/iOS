//  WaiTurnVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/30/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.

import UIKit
import AASquaresLoading
import Alamofire

class WaiTurnVC: UIViewController {

    var id: Int!
    var sections = [Section]()
    var activeSection: Section!
    var timerS : Timer?
    @IBOutlet weak var lblEtapa: LabelsUI!

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        startTimer ()

//        let tempVCA = self.navigationController!.viewControllers
//        for tempVC: UIViewController in tempVCA {
//            if (tempVC is ChronometerVC) {
//                tempVC.removeFromParentViewController()
//            }
//        }

    }

    @IBAction func BtnClose(_ sender: Any) {

        dismiss(animated: true, completion: nil)
        stopTimerTest()

    }

    func getDebateSection(_ completed: @escaping DownloadComplete){

        let DEBATE_USER_URL = "\(BASE_URL)\(DEBATE_URL)\(IdDEBATE_URL)\(id!)"

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

            }
            completed()
        }
    }

    func update() {

        getDebateSection{

            let indexS = self.sections.index(where: {$0.ActiveSection == true})
            let etapa = self.sections[indexS!].name

            self.lblEtapa.text = etapa.capitalized

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
    
}
