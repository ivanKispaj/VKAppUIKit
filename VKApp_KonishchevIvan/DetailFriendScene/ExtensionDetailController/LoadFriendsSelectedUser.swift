//
//  LoadImageView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
import RealmSwift

// MARK: - Подгружаем друзей друга и сохраняем результат в hisFriends
extension DetailUserTableViewController {
    
    func loadFriendsSelectedUser()  {
        let internetConnection = InternetConnectionProxy(internetConnection: InternetConnections(host: "api.vk.com", path: UrlPath.getFriends))
        if let result = self.realmService.readData(FriendsResponse.self)?.where({ $0.id == self.friendsSelected.id }).first {
            self.updateUserFromRealm(from: result)
            if result.countFriends != result.items.count {
                DispatchQueue.global(qos: .default).async {
                    internetConnection.loadFriends(for: String(self.friendsSelected.id), count: "")
                }
            }
        } else {
            DispatchQueue.global(qos: .default).async {
                internetConnection.loadFriends(for: String(self.friendsSelected.id))
                
            }
        }
    }
    
    func setNotificationtokenFriends() {
        if let data = self.realmService.readData(FriendsResponse.self) {
            self.notifiTokenFriends = data.observe { [weak self] (changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("DetailVC UserFriends Signed")
                case let .update(results, _, _, _):
                    let dataFriends = results
                        .where { $0.id == self!.friendsSelected.id }
                        .first
                    if let data = dataFriends {
                        
                        self!.updateUserFromRealm(from: data)
                        
                    }
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
    
    
    private func updateUserFromRealm(from friendsData: FriendsResponse) {
        var arrays = [Friend]()
        let items = friendsData.items
        for friendData in items {
            let friends = Friend()
            
            if friendData.online == 1 {
                friends.online = true
            }
            
            if friendData.banned != nil {
                friends.isBanned = true
            }
            
            if friendData.city != nil {
                friends.city = friendData.city!.title
            }else {
                friends.city = "unknown"
            }
            
            if friendData.lastSeen != nil {
                friends.lastSeenDate = friendData.lastSeen!.time
            }
            
            if  let status = friendData.status {
                friends.status = status
            }
            
            let name = (friendData.fName) + " " + (friendData.lName)
            friends.userName = name
            friends.id = friendData.id
            friends.photo = friendData.photo50
            friends.isClosedProfile = friendData.isClosedProfile
            
            arrays.append(friends)
        }
        let dataFriends = UserDetailsTableData(sectionType: .Friends, sectionData: DetailsSectionData( friends: arrays, friendsCount: friendsData.countFriends))
        
        
        
        if var data = self.dataTable {
            self.dataTable = nil
            if let index = data.firstIndex(where: { $0.sectionType == .Friends }){
                data.remove(at: index)
            }
            data.insert(dataFriends, at: 0)
            self.dataTable = data
        } else {
            self.dataTable = [dataFriends]
        }
        
        self.tableView.reloadData()
    }
}




