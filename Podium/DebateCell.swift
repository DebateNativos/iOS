//
//  LabelsUI.swift
//  Podium
//
//  Created by Carlos M Solis on 10/19/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class DebateCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var debateImage: UIImageView!

    func configureCell(debate: Debate) {


        lblSubject.text = "\(debate.name)"
        lblDate.text = debate.startingDate //convertedDate
        lblTime.text = "\(debate.debateTypeName)"

        if debate.timeStatus == "DONE"{
            debateImage.image = UIImage(named: "Done")
        } else {
            debateImage.image = UIImage(named: "iCon")
        }
        
    }
    
}
