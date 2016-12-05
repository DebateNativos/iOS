//
//  ObserverVC.swift
//  Podium
//
//  Created by Carlos M Solis on 10/31/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import SnapTimer
import AudioToolbox

class ObserverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sTimer: SnapTimerView!
    var timerS : Timer?
    @IBOutlet weak var tableView: UITableView!
    var comment: Comment!
    var comments = [Comment]()
    var debate: Debate!
    var sections = [Section]()
    var activeSection: Section!
    var indexS: Int!
    @IBOutlet weak var lblEtapa: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    var minutesPerUser: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDebateSection{}
        tableView.delegate = self
        tableView.dataSource = self
        startTimer ()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackPressed(_ sender: AnyObject) {

        dismiss(animated: true, completion: nil)
        stopTimerTest()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)as? CommentCell{
            let comment = comments[indexPath.row]
            cell.configureCell(comment: comment)
            return cell

        } else {

            return CommentCell()

        }
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

                self.updateLbl ()
                // self.sections.removeAll()
            }
            completed()
        }
    }

    @IBAction func InfoPressed(_ sender: Any) {

        self.performSegue(withIdentifier: "StagesVC", sender: debate.idDebates)

    }


    func updateLbl (){

        indexS = self.sections.index(where: {$0.ActiveSection == true})

        minutesPerUser = (self.sections[indexS].MinutesPerUser)*60

        self.sTimer.animateOuterToValue(100, duration: Double(minutesPerUser)) {

            self.stopTimerTest()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
        }

        let etapa = self.sections[indexS!].name

        self.navBar.topItem?.title = debate.name
        lblEtapa.text = etapa.capitalized
        lblDate.text = "\(debate.startingDate)"

        lblEtapa.layer.masksToBounds = true
        lblEtapa.layer.cornerRadius = 5
        lblDate.layer.masksToBounds = true
        lblDate.layer.cornerRadius = 5

    }


    func SelectStage () {

        let stageName = sections[indexS!].name

        if stageName.lowercased() == "presentacion inicial" {

            self.performSegue(withIdentifier: "NewComment", sender: nil)

        }else if stageName.lowercased() == "primeras argumentaciones" {

            self.performSegue(withIdentifier: "StagesVC", sender: nil)

        }else if stageName.lowercased() == "NewComment" {

            self.performSegue(withIdentifier: "NewComment", sender: nil)

        }else if stageName.lowercased() == "nuevas argumentaciones" {

            SCLAlertView().showNotice("Lo Sentimos", subTitle: "")

        }else if stageName.lowercased() == "conclusiones" {

            SCLAlertView().showNotice("Lo Sentimos", subTitle: "")

        }

    }

    @IBAction func NewCommentPressed(_ sender: Any) {

        SelectStage ()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? StagesVC {

            if let idDebate = sender as? Int{
                destination.id = idDebate
            }
        }

    }

    func update() {

        getDebateSection{}

    }
    
    func startTimer () {
        
        
        if timerS == nil {
            timerS =  Timer.scheduledTimer(
                timeInterval: TimeInterval(60),
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
