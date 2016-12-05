//
//  PublicVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/26/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class PublicVC: UIViewController {

    var debate: Debate!
    @IBOutlet weak var lblDebName: LabelsUI!
    @IBOutlet weak var lblEtapa: LabelsUI!
    var sections = [Section]()
    var activeSection: Section!
    var timerS : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        getDebateSection {}
        //startTimer()
        // Do any additional setup after loading the view.
    }

    func UpdateLabels () {

        lblDebName.text = debate.name

        if let i = self.sections.index(where: {$0.ActiveSection == true}) {

            lblEtapa.text = self.sections[i].name

        }
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

                self.UpdateLabels ()
                self.sections.removeAll()
            }
            completed()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? StagesVC {

            if let idDebate = sender as? Int{
                destination.id = idDebate
            }
        }

    }

    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

    @IBAction func InfoPressed(_ sender: Any) {

        self.performSegue(withIdentifier: "Stages", sender: debate.idDebates)

    }

    @IBAction func NewQuestionPressed(_ sender: Any) {

     SelectStage ()

    }

    func update () {

        getDebateSection{}

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

    func SelectStage () {

        let i = self.sections.index(where: {$0.ActiveSection == true})

        let stageName = sections[i!].name

        if stageName.lowercased() == "presentacion inicial" {

            self.performSegue(withIdentifier: "Pregunta", sender: debate.idDebates)

        }else if stageName.lowercased() == "primeras argumentaciones" {

            self.performSegue(withIdentifier: "Pregunta", sender: debate.idDebates)

        }else if stageName.lowercased() == "preguntas" {

            self.performSegue(withIdentifier: "Pregunta", sender: debate.idDebates)
            
        }else if stageName.lowercased() == "nuevas argumentaciones" {
            
            SCLAlertView().showSuccess("Lo Sentimos", subTitle: "Ya paso las preguntas XD")
            
        }else if stageName.lowercased() == "conclusiones" {
            
            SCLAlertView().showSuccess("Lo Sentimos", subTitle: "Ya paso las preguntas XD")
            
        }
        
    }
    
}
