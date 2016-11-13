//
//  ObserverVC.swift
//  Podium
//
//  Created by Carlos M Solis on 10/31/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class ObserverVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var comment: Comment!
    var comments = [Comment]()
    var debate: Debate!
    @IBOutlet weak var lblEtapa: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLbl()
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

    func updateLbl (){

        self.navBar.topItem?.title = debate.name
        //lblEtapa.text = debate.description
        lblDate.text = "\(debate.startingDate)"

        lblEtapa.layer.masksToBounds = true
        lblEtapa.layer.cornerRadius = 5
        lblDate.layer.masksToBounds = true
        lblDate.layer.cornerRadius = 5
        
    }
    
    
}
