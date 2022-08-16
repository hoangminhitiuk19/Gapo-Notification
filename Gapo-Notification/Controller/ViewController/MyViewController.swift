//
//  MyViewController.swift
//  Gapo-Notification
//
//  Created by Minh on 8/9/22.
//

import UIKit
import SDWebImage

class MyViewController: UIViewController, UISearchBarDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    var notifications = [DataItem]()
    var searchResults = [DataItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Thông báo"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
        setupSearchBar()
        searchResults = notifications
    }
// PARSE JSON
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
    //------------------------------------------
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "CustomTableViewCell")
    }
    //------------------------------------------
    private func setupSearchBar() {
          definesPresentationContext = true
          navigationItem.searchController = self.searchController
          navigationItem.hidesSearchBarWhenScrolling = false
          searchController.searchBar.delegate = self
          let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
          textFieldInsideSearchBar?.placeholder = "Tìm kiếm"
      }
    //------------------------------------------
    func checkState(state: String,
                    cell: CustomTableViewCell) {
        if state == "read" {
            cell.backgroundColor = UIColor(rgb: 0xFFFFFF)
        } else {
            cell.backgroundColor = UIColor(rgb: 0xECF7E7)
        }
    }
    //------------------------------------------
    func createDateTime(timestamp: String) -> String {
        var strDate = ""
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "GET"
            dateFormatter.timeZone = TimeZone(abbreviation: timezone)
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            strDate = dateFormatter.string(from: date)
        }
        return strDate
    }
    //------------------------------------------
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchResults = notifications.filter{ $0.message.text.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        } else {
            searchResults = notifications
            tableView.reloadData()
        }
    }
}


extension MyViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : notifications.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell",
                                                    for: indexPath) as? CustomTableViewCell {
            var datas = notifications[indexPath.row]
            if searchController.isActive {
                datas = searchResults[indexPath.row]
            } else {
                datas = notifications[indexPath.row]
            }
            cell.configure(semiboldText: datas.subjectName,
                           normalText: datas.message.text,
                           date: createDateTime(timestamp: String(datas.createdAt)),
                           avatarURL: datas.image,
                           iconURL: datas.icon)
            checkState(state: datas.status.rawValue,
                       cell: cell)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if notifications[indexPath.row].status.rawValue == "unread" {
            notifications[indexPath.row].status = .read
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    // Tableview cells automatically set height
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// Update to use RGB
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

