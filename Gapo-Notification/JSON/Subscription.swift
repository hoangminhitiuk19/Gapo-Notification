//
//  Subscription.swift
//  Gapo-Notification
//
//  Created by Dung on 8/10/22.
//

import Foundation

struct Subscription: Codable {
    var targetID: String?
    var targetType: TargetType
    var targetName: String?
    var level: Int
    
    enum CodingKeys: String, CodingKey {
        case targetID = "targetID"
        case targetType,targetName, level
    }
}
