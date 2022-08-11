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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.lineBreakMode = .byWordWrapping
        textField.sizeToFit()
        textField.numberOfLines = 2
        textField.font = .systemFont(ofSize: 20,
                                     weight: .regular)
       // textField.text = information.message.text
        dateField.font = .systemFont(ofSize: 15,
                                     weight: .light)
    }

    public func configure(text: String,
                          date: String,
                          url: String ) {
        textField.text = text
        dateField.text = date
        textField.layoutIfNeeded()
        dateField.layoutIfNeeded()
        avatarImage.sd_setImage(with: URL(string: url),
                                placeholderImage: nil,
                                options: .continueInBackground,
                                completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        dateField.text = nil
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
