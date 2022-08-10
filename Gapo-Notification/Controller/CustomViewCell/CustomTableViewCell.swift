//
//  CustomeTableViewCell.swift
//  Gapo-Notification
//
//  Created by Dung on 8/9/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var emotionImage: UIImageView!
    
    
    var informations : Message?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.lineBreakMode = .byWordWrapping
        textField.numberOfLines = 2
        textField.font = .systemFont(ofSize: 23,
                                     weight: .regular)
        dateField.font = .systemFont(ofSize: 18,
                                     weight: .light)
    }

    override func setSelected(_ selected: Bool,
                              animated: Bool) {
        super.setSelected(selected,
                          animated: animated)
    }
    
    @IBAction func tapSettingsButton(_ sender: UIButton) {
        print("13")
    }
    
}
