//
//  CommentCell.swift
//  Podium
//
//  Created by Carlos M Solis on 11/1/16.
//  Copyright © 2016 Jorge Soler. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblText : UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ comment: Comment) {

        lblName.text = "\(comment.name) \(comment.lastName)"
        lblText.text = "\(comment.text)"

    }

}
