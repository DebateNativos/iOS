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

    var timerS : Timer?
    @IBOutlet weak var lblTimer: UILabel!
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
    var minutesOfUser2: Int = 0
    @IBOutlet weak var lblWarnings: UILabel!
    var email: String!
    var accessToDebate = [ActiveUser]()
    var course: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        getDebateSection{

            self.minutesOfUser2 = self.minutesPerUser
            var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimerLbl), userInfo: nil, repeats: true)

        }
        tableView.delegate = self
        tableView.dataSource = self
        update()
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

            self.performSegue(withIdentifier: "NewComment", sender: self)

        }else if stageName.lowercased() == "primeras argumentaciones" {


            self.performSegue(withIdentifier: "StagesVC", sender: self)

        }else if stageName.lowercased() == "NewComment" {


            self.performSegue(withIdentifier: "NewComment", sender: self)

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

        } else if let destination = segue.destination as? NewCommentVC{


            destination.course = course
            destination.email = email
            destination.debate = debate

            if let debate = sender as? Debate{
                destination.debate = debate
            }

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

    func getComments(_ completed: @escaping DownloadComplete){

        let ACTIVEDEBATES_URL = "\(BASE_URL)\(GET_COMMENTS)\(COURSE)\(course!)\(DEBATE)\(debate.idDebates)"
        Alamofire.request(ACTIVEDEBATES_URL).responseJSON {response in
            let result = response.result

            print(response, result, "--------URL: \(ACTIVEDEBATES_URL)")

            if let dict = result.value as? [Dictionary<String, AnyObject>]{

                self.comments.removeAll()

                for obj in dict {

                    let comment = Comment(comment: obj)
                    self.comments.append(comment)
                    self.tableView.reloadData()
                    print(obj)

                }

                self.comments.reverse()

            }
            completed()
        }

    }

    func update() {

        getDebateSection{}

        UserWarn{

            let i = self.accessToDebate.index(where: {$0.Debate == self.debate.idDebates })

            let warn = self.accessToDebate[i!].Warning
            self.course = self.accessToDebate[i!].Course

            if warn>0 {

                self.lblWarnings.text = ("\(warn)")

                if warn == 3{

                    //EXPULSADO
                }

            }


        }

        getComments{}

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
    
    func updateTimerLbl() {
        
        if self.minutesOfUser2 > 0 {
            let minutes = String(minutesOfUser2 / 60)
            let seconds = String(minutesOfUser2 % 60)
            lblTimer.text = minutes + ":" + seconds
            self.minutesOfUser2 -= 1
        }
        
    }
    
}
