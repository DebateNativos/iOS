//
//  StagesVC.swift
//  Podium
//
//  Created by Carlos M Solis on 11/26/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit
import Alamofire

class StagesVC: UIViewController {

    var id: Int!
    var sections = [Section]()
    var activeSection: Section!
    @IBOutlet weak var lblPresentacionInicial: UILabel!
    @IBOutlet weak var lblPrimerasArgumentaciones: UILabel!
    @IBOutlet weak var lblPreguntas: UILabel!
    @IBOutlet weak var lblNuevasArgumentaciones: UILabel!
    @IBOutlet weak var Conclusiones: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDebateSection{}
        // Do any additional setup after loading the view.
    }

    @IBAction func BackPressed(_ sender: Any) {

        dismiss(animated: true , completion: nil)

    }

    func getDebateSection(_ completed: @escaping DownloadComplete){

        let DEBATE_USER_URL = "\(BASE_URL)\(DEBATE_URL)\(IdDEBATE_URL)\(id!)"

        Alamofire.request(DEBATE_USER_URL).responseJSON {response in
            let result = response.result

            print(response, result, "--------URL: \(DEBATE_USER_URL)")

            if let dict = result.value as? [Dictionary<String, AnyObject>]{

                for obj in dict{

                    self.activeSection = Section(Section: obj)
                    self.sections.append(self.activeSection)

                    print("CONTANDO - \(self.sections.count)")



                }

                self.SelectStage()
                self.sections.removeAll()

            }
            completed()
        }
    }

    func SelectStage () {

        let i = self.sections.index(where: {$0.ActiveSection == true})

        let stageName = sections[i!].name

        if stageName.lowercased() == "presentacion inicial" {

            lblPresentacionInicial.font = UIFont.boldSystemFont(ofSize: 20)

        }else if stageName.lowercased() == "primeras argumentaciones" {

            lblPrimerasArgumentaciones.font = UIFont.boldSystemFont(ofSize: 20)

        }else if stageName.lowercased() == "preguntas" {

            lblPreguntas.font = UIFont.boldSystemFont(ofSize: 20)

        }else if stageName.lowercased() == "nuevas argumentaciones" {
            
            lblNuevasArgumentaciones.font = UIFont.boldSystemFont(ofSize: 20)
            
        }else if stageName.lowercased() == "conclusiones" {
            
            Conclusiones.font = UIFont.boldSystemFont(ofSize: 20)
            
        }
        
    }
    
}
