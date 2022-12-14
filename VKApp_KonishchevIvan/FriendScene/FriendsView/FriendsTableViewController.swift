//
//  FriendsTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//



import UIKit
import RealmSwift



class FriendsTableViewController: UITableViewController, UISearchBarDelegate, FriendsSetData {
    
    var notifiToken: NotificationToken?
    var  realmService: RealmService!
    
    let queue: OperationQueue  = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        queue.name = "friendScene"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    @IBOutlet weak var searchBar: CustomCodeSearchBar!
    @IBOutlet weak var headerTableView: UIView!
    @IBOutlet weak var headerSubview: UIView!
    weak var activityIndicator: UIActivityIndicatorView!
    
    struct DataSection {
        var header: String = ""
        var row: [Friend] = []
        init(header: String, row: [Friend]){
            self.header = header
            self.row = row
        }
    }
    
    var posibleFriends: DataSection!
    var friends: [DataSection] = []
    
    // Исходный массив друзей
    
    var friendsArray: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmService = RealmService()
        getActivityIndicatorLoadData()
        setNotificationtoken()
        self.activityIndicator.startAnimating()
        self.searchBar!.delegate = self
        registerCell()
        loadMyFriends()
        
        tableView.register(CustomHeaderCell.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Operation....
        let loadData = OperationLoadFriendsFromRealm(friendId: NetworkSessionData.shared.testUser)
        let getFriendsViewData = OperationFriendViewData(setView: self)
        getFriendsViewData.addDependency(loadData)
        queue.addOperation(loadData)
        OperationQueue.main.addOperation(getFriendsViewData)
        // ......
    }
    
    //MARK: - SearchBar Method
    // SearchBar FirstResponder
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.tapInSearchBar()
        return true
    }
    
    
    // MARK: - Table view data source
    
    // количество секций с одной буквой
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friends.count
    }
    
    // количество строк таблици в одной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends[section].row.count
    }
    
    // Отрисовка ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = friends[indexPath.section].row[indexPath.row]
        let section = friends[indexPath.section].header
        
        if section == "Возможные друзья" {
            let cell: ExtendTableUserCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setCelldata(from: data)
            return cell
            
        } else {
            let cell: SimpleTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setCellData(toFriendsScene: data)
            return cell
        }
    }
    
    // Действия при выборе ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let friendSelected = friends[indexPath.section].row[indexPath.row]
        if  friendSelected.isBanned  {
            let allert = AllertWrongUserData().getAllert(title: "Сообщение", message: "Пользователь забанен")
            present(allert, animated: true)
        } else if friendSelected.isClosedProfile {
            let allert = AllertWrongUserData().getAllert(title: "Сообщение", message: "Профиль пользователя скрыт!")
            present(allert, animated: true)
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "DetailUserTableView") as? DetailUserTableViewController else { return }
            nextVC.modalPresentationStyle = .automatic
            nextVC.friendsSelected = friendSelected
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    //кастомный Header ячеек
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderCell") as! CustomHeaderCell
        
        let sectionsName = friends[section].header
        view.nameSection.text = sectionsName
        
        if sectionsName == "Возможные друзья" {
            
            view.countFriends.text = " "
            view.action.text = "Показать все"
            
            
            return view
        } else {
            let friendCount = self.friendsArray.first?.countFriends ?? 0
            view.countFriends.text = String(friendCount) 
            view.action.text = "Списки"
            return view
        }
    } 
    
    private func registerCell() {
        tableView.register(SimpleTableCell.self)
        tableView.register(ExtendTableUserCell.self)
    }
    
    
    
    func setData(from data: [Friend]) {
        self.friendsArray = data
        self.setDataSectionTable()
        self.activityIndicator.stopAnimating()
        self.tableView.reloadData()
    }
    
}

