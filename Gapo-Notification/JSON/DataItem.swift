//
//  DataItem.swift
//  Gapo-Notification
//
//  Created by Dung on 8/10/22.
//

import Foundation

struct DataItem: Codable {
    let id,type: String
    var title: Title
    let message: Message
    let image: String
    let icon: String
    var status: Status
    let subscription: Subscription?
    let readAt, createdAt, updatedAt, receivedAt: Int
    let imageThumb, animation: String
    let tracking: String?
    let subjectName: String
    let isSubscribed: Bool
}
