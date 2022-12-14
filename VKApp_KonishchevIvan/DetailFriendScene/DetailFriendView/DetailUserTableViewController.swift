//
//  DetailUserTableViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//


import UIKit
import RealmSwift

class DetailUserTableViewController: UITableViewController, TableViewDelegate {
    
   
    // Данные пользователя которого выбрали на предыдущем контроллере (FriendsTableViewController)
    var friendsSelected: Friend!
    // Realm notification and service
    var notifiTokenPhoto: NotificationToken?
    var notifiTokenFriends: NotificationToken?
    var notifiTokenWall: NotificationToken?
    var realmService: RealmService!
    
    
    var frameImages: [CGRect]?
    var currentFrameImages: CGRect?
    var collectionFrame: CGRect?
    var currentImage: Int?
    
    // переменная для следующего контроллера
    var nextViewData: [ImageAndLikeData] = []
    // данные для отображения секций таблицы
    var dataTable: [UserDetailsTableData]!
    
    var currentImageTap: Int!
    
    @IBOutlet weak var detailAvatarHeader: UIImageView!
    @IBOutlet weak var detailUserNameLable: UILabel!
    @IBOutlet weak var detailUserInfoLable: UILabel!
    @IBOutlet weak var detailUserAccountLable: UILabel!
    @IBOutlet weak var detailButtonMessage: UIButton!
    @IBOutlet weak var detailButtonCall: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realmService = RealmService()
        self.title = self.friendsSelected.userName
        self.setNotificationtokenWall()
        self.setNotificationTokenPhoto()
        self.setNotificationtokenFriends()
        setHeaderDetailView()
        registerCells()
        tableView.register(CustomHeaderCell.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderCell")
        self.loadDataTable()
        
    }
    
    
    deinit {
        print("DetailUserController deinit!  ")
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let data = self.dataTable {
            return data.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = self.dataTable?[section].sectionData else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderCell") as! CustomHeaderCell
        switch section {
        case 0:
            let tap = UITapGestureRecognizer(target: self, action: #selector(FriendsHeaderNextTap))
            
            view.nameSection.text = "Друзья"
            view.countFriends.text = String(data.friensCount)
            view.action.text = ">"
            let friendsTap = view.action
            friendsTap.addGestureRecognizer(tap)
            
        case 1:
            let tap = UITapGestureRecognizer(target: self, action: #selector(photoHeaderNextTap))
            view.nameSection.text = "Фотографии"
            let count = data.photo?.count  ?? 0
            view.countFriends.text = String(count)
            view.action.text = ">"
            let photoSectionTap = view.action
            photoSectionTap.addGestureRecognizer(tap)
            
        default:
            
            return nil
        }
        
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = dataTable?[indexPath.section].sectionData else {
            preconditionFailure("Error")
        }
        
        switch dataTable[indexPath.section].sectionType {
        case .Friends:
            let cell: CouruselTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.collectionData = data.friends
            cell.delegate = self
            return cell
        case .Gallary:
            
            let cell: GallaryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            if let photo = data.photo {
                cell.gallaryData = photo
            }
            cell.delegate = self
            cell.delegateIndexPath = indexPath
            cell.delegateFrameImages = self
            return cell
        case .SingleFoto:
            let cell: SinglePhotoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            cell.delegateIndexPatch = indexPath
            cell.delegate = self
            cell.likeControll.delegate = self
            cell.likeControll.indexPath = indexPath
            cell.setCellData(from: data, to: self.friendsSelected)
            return cell
            
            
        case .link:
            let cell: LinkTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            cell.setCellData(from: data, to: self.friendsSelected)
            
            return cell
        case .newsText:
            let cell: DetailPlugCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.testPlugText.text = "NewsText"
            return cell
            
        case .video:
            let cell: DetailPlugCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.testPlugText.text = "VideoCell"
            return cell
            
        case .unknown:
            let cell: DetailPlugCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            cell.testPlugText.text = "Unknown"
            return cell
            
        case .linkPhoto:
            let cell: DetailPlugCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.testPlugText.text = "LinkPhoto"
            return cell
            
        }
    }
    
    private func registerCells() {
        tableView.register(CouruselTableViewCell.self)
        tableView.register(GallaryTableViewCell.self)
        tableView.register(SinglePhotoTableViewCell.self)
        tableView.register(LinkTableViewCell.self)
        tableView.register(DetailPlugCell.self)
    }
    
    //MARK: - TableViewDelegate method
    func selectRow(nextViewData: [ImageAndLikeData], indexPath: IndexPath) {
        
        self.nextViewData = nextViewData
        guard let data = self.dataTable else { return }
        
        let sectionType = data[indexPath.section].sectionType
        
        if sectionType == .Gallary {
            getViewGallary(to: indexPath)
        } else if sectionType == .SingleFoto {
            self.currentImage = 0
            let frame = self.tableView.rectForRow(at: indexPath)
            let frame1 = CGRect(x: frame.origin.x, y: 0, width: frame.width, height: frame.height)
            self.frameImages = [frame1]
            self.currentFrameImages = frame1
            self.collectionFrame = frame
            getViewGallary(to: indexPath)
        }
        
    }
    
    //MARK: - Действия при нажатии на кнопки хедера
    @objc func photoHeaderNextTap() {
        print("tapToPhotoGallaryHeaderButton")
    }
    
    @objc func FriendsHeaderNextTap() {
        print("TapToFriendsHeaderButton")
    }
}

// MARK: - методы для делегата like controll !!
extension DetailUserTableViewController: LikeDelegate {
    
    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let data = self.dataTable![indexPath.section].sectionData
        var likeStatus: Bool = false
        let countLike = data.likes.count
        if data.likes.userLike == 1 {
            likeStatus = true
        }
        return  [ countLike: likeStatus]
        
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.dataTable![indexPath.section].sectionData.likes.count = countLike
        if likeStatus {
            self.dataTable![indexPath.section].sectionData.likes.userLike = 1
        } else {
            self.dataTable![indexPath.section].sectionData.likes.userLike = 0
        }
    }
}

//MARK: - delegate SetFrameImages
extension DetailUserTableViewController: SetFrameImages {
    func setFrameImages(_ frame: [CGRect], currentFrame: CGRect) {
        self.frameImages = frame
        self.currentFrameImages = currentFrame
    }
    
    func setCurrentImage(_ currentImage: Int) {
        self.currentImage = currentImage
    }
    
    private func getViewGallary(to indexPath: IndexPath) {
        
        var cellRect = self.tableView.rectForRow(at: indexPath) //Получаем область нужной ячейки
        let contentOffset = tableView.contentOffset //смещение контента таблицы относительно начального нулевого положения
        let y_coordinate = cellRect.origin.y - contentOffset.y //чистая y координата ячейки относительно экранных координат
        cellRect.origin.y = y_coordinate
        self.collectionFrame = cellRect
        
        //MARK: - Custom push imageGallary
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "GallaryVievController") as? GallaryViewController else { return }
        
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.transitioningDelegate = nextVC
        nextVC.collectionViewFrame = self.collectionFrame
        nextVC.currentFrame = self.currentFrameImages
        nextVC.frameArray = self.frameImages
        nextVC.arrayPhoto = nextViewData
        nextVC.title = "Фото галлерея"
        nextVC.currentImage = self.currentImage!
        self.present(nextVC, animated: true)
    }
    
}


