//
//  UserGroupTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit
import RealmSwift


class UserGroupTableViewController: UITableViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: CustomCodeSearchBar!
    
    let realmService = RealmService()
    let service = InternetConnectionProxy(internetConnection:  InternetConnections(host: "api.vk.com", path: UrlPath.getGroups))
    var dataGroups: [ItemsGroup]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.register(SimpleTableCell.self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
// Promises!!!
        service.getUrlUserGroup()
            .then(on: .global(qos: .userInitiated), (service.getDataUserGroup(_:)))
            .then(service.getParseData(_:))
            .done(on: .main) {[weak self] result in
                self?.dataGroups = result
                self?.tableView.reloadData()
            }.catch { error in
                print(error)
            }
    }
    
    deinit {
        print("Group Deinit!")
    }
    //MARK: - SearchBar Method
    // SearchBar FirstResponder
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.tapInSearchBar()
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.dataGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SimpleTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        guard let data = self.dataGroups else { return cell}
        cell.setCellData(toGroupScene: data[indexPath.row])
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        tableView.customzeSwipeView(for: self.tableView)
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delite = UIContextualAction(style: .destructive, title: "Выйти") { [weak self] action,view, completionHandler in
            
            guard let data = self!.dataGroups else { return }
            let id = data[indexPath.row].id
            self!.leaveGroup(to: id) { status, message in
                if status {
                    if let index = data.firstIndex(of: data[indexPath.row]) {
                        self?.dataGroups?.remove(at: index)

                    }
                    DispatchQueue.main.async {
                        
                        self!.realmService.deliteData(data[indexPath.row],cascading: true)
                    }
                    DispatchQueue.main.async {
                        self!.tableView.deleteRows(at: [indexPath], with: .left)
                    }
                }else {
                    print("Failure Delite groups")
                }
            }
            
            tableView.reloadData()
            
            print("Выйти из группы!")
        }
        
        delite.image = UIImage(systemName: "figure.walk") // minus.circle.fill
        
        delite.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.2624110008)
        let configuration =  UISwipeActionsConfiguration(actions: [delite])
        return configuration
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let details = UIContextualAction(style: .normal, title: "Подробно") {  action, view, completionHandler in
            print("Подробности о группе")
            
        }
        
        let message = UIContextualAction(style: .normal, title: "Написать") {  action,view, completionHandler in
            
            print("Написать сообщение в группу")
        }
        message.image = UIImage(systemName: "quote.bubble")
        message.backgroundColor = #colorLiteral(red: 0.8213813901, green: 0.8213813901, blue: 0.8213813901, alpha: 0.3316367013)
        
        details.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        details.backgroundColor = #colorLiteral(red: 0.8213813901, green: 0.8213813901, blue: 0.8213813901, alpha: 0.3316367013)
        let configuration = UISwipeActionsConfiguration(actions: [details, message])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}




