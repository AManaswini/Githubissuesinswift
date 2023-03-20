//
//  IssueTableViewCell.swift
//  Github issues
//
//  Created by Manaswini Aitha on 22/01/23.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var issueImage: UIImageView!
    @IBOutlet weak var title: UILabel!

}
