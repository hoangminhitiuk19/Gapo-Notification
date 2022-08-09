//
//  MyViewController.swift
//  Gapo-Notification
//
//  Created by Dung on 8/9/22.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
    }

    func parseJSON() {
        guard let path = Bundle.main.path(forResource: "noti", ofType: "json") else {
            return
        }
        var result: Notification?
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Notification.self, from: jsonData)
            
            if let result = result {
                print(result.data.count)
            } else {
                print("Failed to parse")
            }
        }
        catch {
            print("Error: \(error)")
        }
    }

 

}
