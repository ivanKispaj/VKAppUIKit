//
//  OperationFriendViewData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 03.06.2022.
//

import Foundation

final class OperationFriendViewData: Operation {
    
    var control: FriendsSetData
    
    init(setView: FriendsSetData) {
        self.control = setView
    }
    
    override func main() {
        guard let option = dependencies.first as? OperationLoadFriendsFromRealm else {
            print("Data not parsed")
            return
        }
        guard let data = option.friendsData else { return }
        
        control.setData(from: data)
        
    }
}
