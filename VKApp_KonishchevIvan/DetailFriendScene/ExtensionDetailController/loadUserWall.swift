//
//  loadUserWall.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.04.2022.
//
//MARK: - Необходимо доработать контроллер для разных типов ячеек таблицы!!!! Еще не финальная часть!

import UIKit
import RealmSwift

extension DetailUserTableViewController {
    
    func loadUserWall () {
        let internetConnection = InternetConnectionProxy(internetConnection: InternetConnections(host: "api.vk.com", path: UrlPath.getWall))

        let wallData = self.realmService.readData(UserWallResponse.self)?.where { $0.id == self.friendsSelected.id }.first?.items
        if let data = wallData {
            self.updateWallData(from: data)
        }
        DispatchQueue.global(qos: .utility).async {
            internetConnection.getUserWall(for: String(self.friendsSelected.id))
        }
    }
    
    //MARK: - setNotificationTokenWall
    
    func setNotificationtokenWall() {
        if let data = self.realmService.readData(UserWallResponse.self) {
            self.notifiTokenWall = data.observe { [weak self] (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("DetailVC userWall Signed")
                case let .update(results, _, _, _):
                    let dataWall = results
                        .where { $0.id == self!.friendsSelected.id }
                        .first!
                        .items
                    self!.updateWallData(from: dataWall)
                    
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
    
    private func getPhotoUrl(_ photoArr: List<WallSizes>) -> WallSizes {
        if let photoData = photoArr.first(where: { $0.type == "y" }) {
            return photoData
        } else if let photoData = photoArr.first (where: { $0.type == "x" }) {
            return photoData
        } else if let photoData = photoArr.first (where: { $0.type == "k" }) {
            return photoData
        } else if let photoData = photoArr.first(where: { $0.type == "q"}) {
            return photoData
        } else if let photoData = photoArr.first(where: { $0.width > 200}) {
            return photoData
        } else if let photoData = photoArr.first(where: { $0.width > 130}) {
            return photoData
        }
        let photoData = photoArr.first(where: { $0.width > 90})
        return photoData!
    }
    
    private func getPhotoNewsHistory(_ photoArray: [WallSizes]) -> String {
        
        let url = photoArray.first { $0.width > 300 }?.url
        return url ?? " "
    }
    
    
    private func updateWallData(from wallDatas: List<UserWallItems>) {
        var wallData: [UserDetailsTableData] = []
        for item in wallDatas {
            var sectionData = DetailsSectionData()
            sectionData.id = item.id
            sectionData.ownerId = item.ownerId
            sectionData.date = item.date
            sectionData.textNews = item.text
            
            if let likes = item.likes {
                sectionData.likes = likes
            }
            
            if let views = item.views {
                sectionData.views = views
            }
            
            var typeSection: SectionType = .unknown
            
            if let attachments = item.attachments.first{
                if let photo = attachments.photo {
                    typeSection = .SingleFoto
                    var likeStatus = false
                    if sectionData.likes.userLike == 1 {
                        likeStatus = true
                    }
                    
                    let size = getPhotoUrl(photo.sizes)
                    let photos = ImageAndLikeData(image: size.url, likeStatus: likeStatus, height:CGFloat(size.height), width: CGFloat(size.width), seenCount: sectionData.views?.count ?? 0)
                    sectionData.photo = [photos]
                    sectionData.urlNewsImage = size.url
                    
                } else if let link = attachments.link {
                    if let photo = link.photo {
                        typeSection = .linkPhoto
                        
                        sectionData.urlNewsImage = getPhotoUrl(photo.sizes).url
                    }else {
                        typeSection = .link
                    }
                    
                    sectionData.linkUrl = link.url
                    sectionData.captionNews = link.caption
                    sectionData.titleNews = link.title
                    
                }
            } else if let attachments = item.wallcopyHystory.first?.attachments {
                
                for attachData in attachments {
                    if let photo = attachData.photo {
                        typeSection = .SingleFoto
                        let size = getPhotoUrl(photo.sizes)
                        sectionData.urlNewsImage = size.url
                        var likeStatus = false
                        if sectionData.likes.userLike == 1 {
                            likeStatus = true
                        }
                        let photos = ImageAndLikeData(image: size.url, likeStatus: likeStatus, height:CGFloat(size.height), width: CGFloat(size.width), seenCount: sectionData.views?.count ?? 0)
                        sectionData.photo = [photos]
                        
                    } else if let link = attachData.link {
                        if let photo = link.photo {
                            typeSection = .linkPhoto
                            sectionData.urlNewsImage = getPhotoUrl(photo.sizes).url
                        }else {
                            typeSection = .link
                        }
                        sectionData.linkUrl = link.url
                        sectionData.captionNews = link.caption
                        sectionData.titleNews = link.title
                        
                    }
                    
                }
                
            }
            let data = UserDetailsTableData(sectionType: typeSection, sectionData: sectionData)
            wallData.append(data)
            
        }
        
        if let data = self.dataTable {
            self.dataTable = nil
            
            if let photoIndex = data.firstIndex(where: { $0.sectionType == .Gallary }) {
                let photoData = data[photoIndex]
                wallData.insert(photoData, at: 0)
                
            }
            if let friendsIndex = data.firstIndex(where: { $0.sectionType == .Friends }) {
                let friendData = data[friendsIndex]
                wallData.insert(friendData, at: 0)
                
            }
        }
        self.dataTable = wallData
        self.tableView.reloadData()
    }
}


