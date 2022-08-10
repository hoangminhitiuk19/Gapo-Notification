//
//  MyViewController.swift
//  Gapo-Notification
//
//  Created by Dung on 8/9/22.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    var notifications = [DataItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
    }

    func parseJSON() {
        guard let path = Bundle.main.path(forResource: "noti",
                                          ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(Notification.self,
                                                  from: jsonData)
            self.notifications = result.data
            self.tableView.reloadData()
        } catch {
            print("Error: \(error)")
        }
    }

    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
}


extension MyViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell",
                                                    for: indexPath) as? CustomTableViewCell {
            let information = self.notifications[indexPath.row]
            cell.textField.text = information.message.text
            cell.dateField.text = String(information.createdAt)
            cell.avatarImage.downloaded(from: information.image)
            cell.emotionImage.downloaded(from: information.icon)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        print("selected cell: ")
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension UIImageView {
    func downloaded(from url: URL,
                    contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String,
                    contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}



