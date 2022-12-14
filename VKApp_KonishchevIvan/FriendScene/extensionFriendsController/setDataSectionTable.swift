//
//  setDataSectionTable.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 06.03.2022.
//

import UIKit

//MARK: - Extension FriendsTableViewController

// Добавляет в массив friends возможных друзей и тип секции
extension FriendsTableViewController {
    
    func setDataSectionTable() {
        
        let dataVKPhoto =  "https://avatars.mds.yandex.net/get-zen_doc/1535103/pub_5f2dbed8c1a7b87558486d42_5f2dc071d1ab9668ff0d0ad8/scale_1200"
        let friendVK = Friend()
        friendVK.userName = "VKGroup"
        friendVK.photo = try? Data(contentsOf: URL(string: dataVKPhoto)!)
        friendVK.id = 1
        friendVK.city = "unknown"
        friendVK.lastSeenDate = 5212321
        friendVK.online = true
        friendVK.status = "Оффициальная группа VK"
        self.posibleFriends = DataSection(header: "Возможные друзья", row: [friendVK])
        
        self.friends = []
        self.friends.append(posibleFriends)
        self.friends.append(DataSection(header: "Друзья" , row: self.friendsArray))
    }
}

