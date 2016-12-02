//
//  PublicVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/26/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire

class PublicVC: UIViewController {

    var debate: Debate!
    @IBOutlet weak var lblDebName: LabelsUI!
    @IBOutlet weak var lblEtapa: LabelsUI!
    var sections = [Section]()
    var activeSection: Section!

    override func viewDidLoad() {
        super.viewDidLoad()
        getDebateSection {}
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
        
        self.performSegue(withIdentifier: "Pregunta", sender: nil)
        
    }
}
