//
//  CustomeTableViewCell.swift
//  Gapo-Notification
//
//  Created by Minh on 8/9/22.
//

import UIKit

extension UIFont {
    static var appFontSize:CGFloat { return 14 }
    
    static var appNormalFont: UIFont {
        return UIFont(name: "SF Pro Text-Regular",
                      size: appFontSize)
                ?? UIFont.systemFont(ofSize: appFontSize)
        
    }
    
    static var appSemiFont: UIFont {
        return UIFont(name: "SF Pro Text-Semibold",
                      size: appFontSize)
                ?? UIFont.boldSystemFont(ofSize: appFontSize)
    }
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.lineBreakMode = .byWordWrapping
        textField.numberOfLines = 2
        avatarImage.makeRounded()
    }

    public func configure(semiboldText: String,
                          normalText: String,
                          date: String,
                          avatarURL: String,
                          iconURL: String ) {
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.appNormalFont,
        ]
        let boldAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.appSemiFont,
        ]
        let attributedText = NSMutableAttributedString(string: normalText,
                                                       attributes: attributes)
        let range = (normalText as NSString).range(of: semiboldText)
        attributedText.setAttributes(boldAttributes, range: range)
        textField.attributedText = attributedText
        dateField.text = date
        avatarImage.sd_setImage(with: URL(string: avatarURL),
                                placeholderImage: nil,
                                options: .continueInBackground,
                                completed: nil)
        iconImage.sd_setImage(with: URL(string: iconURL),
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
        print("ok settings button")
    }
}

extension UIImageView {
    func makeRounded() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}


