//
//  CommentCell.swift
//  Podium
//
//  Created by Carlos M Solis on 11/1/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTeacher: UILabel!
    @IBOutlet weak var lblCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ course: Course) {
        
        lblName.text = "\(course.Name)"
        lblTeacher.text = "\(course.Teacher)"
       // lblCode.text = "\(course.code)"

    }
    
}
