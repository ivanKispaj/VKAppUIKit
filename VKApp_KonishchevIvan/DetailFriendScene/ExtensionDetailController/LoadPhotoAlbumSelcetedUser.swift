//
//  LoadPhotoAlbumSelcetedUser.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

//MARK: - Подгружаем фото выбранного друга

extension DetailUserTableViewController {
    
    func loadPhotoAlbumSelctedUser ()  {
        let internetConnection = InternetConnectionProxy(internetConnection: InternetConnections(host: "api.vk.com", path: UrlPath.getAllPhoto))
        let photoData = self.realmService.readData(PhotoResponse.self)?.where { $0.id == self.friendsSelected.id }.first?.items
        if let data = photoData {
            self.updateUserPhotoData(from: data)
            
        }
        
        DispatchQueue.global(qos: .utility).async {
            internetConnection.LoadPhotoUser(for: String(self.friendsSelected.id))
        }
    }
    
    func setNotificationTokenPhoto() {
        if let data = self.realmService.readData(PhotoResponse.self) {
            self.notifiTokenPhoto = data.observe { [weak self] (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("DetailVC UserPhoto Signed")
                case let .update(results, _, _, _):
                    let dataPhoto = results
                        .where { $0.id == self!.friendsSelected.id }
                        .first!
                        .items
                    self!.updateUserPhotoData(from: dataPhoto)
                    
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
    
}



extension DetailUserTableViewController {
    
    func updateUserPhotoData(from photoData: List<PhotoItems>)  {
        
        var imageArray = [ImageAndLikeData]()
        
        for photoArray in photoData {
            var imageArr = ImageAndLikeData(image: "", likeStatus: false, likeLabel: 0, height: 0, width: 0,seenCount: 0)
            imageArr.likeStatus = false
            imageArr.likeLabel = photoArray.likes!.count
            for photo in photoArray.photo {
                if photo.type == "y" {
                    imageArr.image = photo.url
                    imageArr.height = CGFloat(photo.height)
                    imageArr.width = CGFloat(photo.width)
                    imageArray.append(imageArr)
                    break
                }
            }
        }
        let userDetailsTableData = UserDetailsTableData(sectionType: .Gallary, sectionData: DetailsSectionData(photo: imageArray))
        
        
        if var data = self.dataTable {
            self.dataTable = nil
            
            if let index = data.firstIndex(where: { $0.sectionType == .Gallary }) {
                data.remove(at: index)
            }
            if data.count >= 1 {
                data.insert(userDetailsTableData, at: 1)
            } else {
                data.append(userDetailsTableData)
            }
            self.dataTable = data
        } else {
            self.dataTable = [userDetailsTableData]
        }
        self.tableView.reloadData()
    }
}
