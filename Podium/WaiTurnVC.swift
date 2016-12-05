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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func BtnClose(_ sender: Any) {

        dismiss(animated: true, completion: nil)

    }

    func getDebateSection(_ completed: @escaping DownloadComplete){

        let DEBATE_USER_URL = "\(BASE_URL)\(DEBATE_URL)\(IdDEBATE_URL)\(id)"

        Alamofire.request(DEBATE_USER_URL).responseJSON {response in
            let result = response.result

            print(response, result, "--------URL: \(DEBATE_USER_URL)")

            if let dict = result.value as? [Dictionary<String, AnyObject>]{

                for obj in dict{

                    self.activeSection = Section(Section: obj)
                    self.sections.append(self.activeSection)

                    print("CONTANDO - \(self.sections.count)")
                    
                }
                self.sections.removeAll()
            }
            completed()
        }
    }
    
    
}
