//
//  Message.swift
//  Gapo-Notification
//
//  Created by Dung on 8/10/22.
//

import Foundation

struct Message: Codable {
    let text: String
    let highlights: [Highlight]
}
