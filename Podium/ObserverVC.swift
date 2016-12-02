//
//  ObserverVC.swift
//  Podium
//
//  Created by Carlos M Solis on 10/31/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire

class ObserverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var comment: Comment!
    var comments = [Comment]()
    var debate: Debate!
    var sections = [Section]()
    var activeSection: Section!
    @IBOutlet weak var lblEtapa: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        getDebateSection{}
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackPressed(_ sender: AnyObject) {

        dismiss(animated: true, completion: nil)

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

                for obj in dict{

                    self.activeSection = Section(Section: obj)
                    self.sections.append(self.activeSection)

                    print("CONTANDO - \(self.sections.count)")

                    self.updateLbl ()

                }
                self.sections.removeAll()
            }
            completed()
        }
    }

    func updateLbl (){

        let i = self.sections.index(where: {$0.ActiveSection == true})

        self.navBar.topItem?.title = debate.name
        lblEtapa.text = self.sections[i!].name
        lblDate.text = "\(debate.startingDate)"
        
        lblEtapa.layer.masksToBounds = true
        lblEtapa.layer.cornerRadius = 5
        lblDate.layer.masksToBounds = true
        lblDate.layer.cornerRadius = 5
        
    }
    
    
}
