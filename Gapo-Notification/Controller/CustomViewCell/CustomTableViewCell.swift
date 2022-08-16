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
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.lineBreakMode = .byWordWrapping
        textField.numberOfLines = 2
        avatarImage.makeRounded()
    }

    public func configure(semiboldText: String,
                          normalText: String,
                          date: String,
                          avatarURL: String,
                          iconURL: String ) {
        textField.attributedText = NSMutableAttributedString()
            .semibold(semiboldText)
            .normal(changeText(normalText: normalText,
                               semiboldText: semiboldText))
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
    
    func changeText (normalText: String, semiboldText: String) -> String {
        var text: String = normalText
        if normalText.contains(semiboldText) {
            text = text.replacingOccurrences(of: semiboldText,
                                             with: "",
                                             options: NSString.CompareOptions.literal,
                                             range: nil)
        }
        return text
    }
}

extension UIImageView {
    
    func makeRounded() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}

extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var semiFont:UIFont { return UIFont(name: "SF Pro Text-Semibold",
                                        size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "SF Pro Text-Regular",
                                          size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func semibold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : semiFont,
        ]
        
        self.append(NSAttributedString(string: value,
                                       attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value,
                                       attributes:attributes))
        return self
    }
}
