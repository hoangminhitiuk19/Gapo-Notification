//
//  MyViewController.swift
//  Gapo-Notification
//
//  Created by Dung on 8/9/22.
//



/*
 TO DO LIST :                                                                       CHECKBOX
 1. Import Font                                                     ||                  X
 2. Atributed text: CHu Duc Minh is semibold, other is regular      ||                  X
 3. Round Avatar                                                    ||                  X
 4. Emoji display                                                   ||                  X
 5. Read and unread state                                           ||                  X
 6. Search                                                          ||                  O
 */

import UIKit
import SDWebImage

class MyViewController: UIViewController, UISearchBarDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    var notifications = [DataItem]()
    
    var messageText = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Thông báo"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
        setupSearchBar()
        
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
    
    private func setupSearchBar() {
          definesPresentationContext = true
          navigationItem.searchController = self.searchController
          navigationItem.hidesSearchBarWhenScrolling = false
          searchController.searchBar.delegate = self
          let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
          textFieldInsideSearchBar?.placeholder = "Tìm kiếm"
      }
    
    func checkState(state: String, cell: CustomTableViewCell) {
        if state == "read" {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = UIColor(rgb: 0xECF7E7)
        }
    }
    
    func search(){
    
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
            let datas = notifications[indexPath.row]
            cell.configure(semiboldText: datas.subjectName,
                           normalText: datas.message.text,
                           date: String(datas.createdAt),
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
        print("selected cell: \(notifications[indexPath.row].status.rawValue)")
        if notifications[indexPath.row].status.rawValue == "unread" {
            notifications[indexPath.row].status = .read
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


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


