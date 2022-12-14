//
//  LoadMyFriends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 22.04.2022.
//
// 387485849
import UIKit
import RealmSwift

extension FriendsTableViewController {
    
    //MARK: - Запрос друзей через API VK (для теста использую другого человека, т.к у меня мало друзей для вывода)
    //   После теста заменить id пользователя на id NetworkSessionData.shared.userId!
    
    func loadMyFriends() {
        guard let ID = NetworkSessionData.shared.userId else { return }
        let internetConnection = InternetConnectionProxy(internetConnection:  InternetConnections(host: "api.vk.com", path: UrlPath.getFriends))
        if let result = self.realmService.readData(FriendsResponse.self)?.where({ $0.id == ID}).first {
            self.parseData(from: result)
            if result.countFriends != result.items.count {
            
                DispatchQueue.global(qos: .default).async {
                    internetConnection.loadFriends(for: String(ID), count: "")
                }
            }
        } else {
            DispatchQueue.global(qos: .default).async {
                internetConnection.loadFriends(for: String(ID))
                
            }
        }
    }
    
    func setNotificationtoken() {
        if let data = self.realmService.readData(FriendsResponse.self) {
            self.notifiToken = data.observe { [weak self](changes: RealmCollectionChange) in
                switch changes {
                case .initial(_):
                    print("FriendsController Signed ")
                case let .update(results, _, _, _):
                    guard let ID = NetworkSessionData.shared.userId else { return }
                    if let response = results.where({ $0.id == ID }).first {
                        if response.countFriends != self?.friendsArray.count {
                            self?.parseData(from: response)
                        }
                    }
                    
                case .error(_):
                    print("Asd")
                }
            }
        }
    }
    
    private func parseData(from response: FriendsResponse) {
        var arrays = [Friend]()
        let items = response.items
        for friendData in items {
            let friends = Friend()
            friends.countFriends = response.countFriends
            if friendData.online == 1 {
                friends.online = true
            }
            
            if friendData.banned != nil {
                friends.isBanned = true
            }
            
            if friendData.city != nil {
                friends.city = friendData.city!.title
            } else {
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
        
        DispatchQueue.main.async {
            self.setData(from: arrays)
        }
    }
    
}


