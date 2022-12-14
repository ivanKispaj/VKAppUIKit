//
//  OperationLoadFriendFromRealm.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 03.06.2022.
//

import Foundation
import RealmSwift

 final class OperationLoadFriendsFromRealm: Operation {
    private var realmService: RealmService
    private var friendId: Int
    private(set) var friendsResponse: FriendsResponse?
    var friendsData: [Friend]?
     
    init(friendId: Int) {
        self.realmService = RealmService()
        self.friendId = friendId
    }
     
     
    override func main() {
        guard let response = self.realmService.readData(FriendsResponse.self)?.where({ $0.id == self.friendId }).first else { return }
        self.friendsResponse = response
        self.parseData(from: self.friendsResponse!)
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
         self.friendsData = arrays
      }
     
     
}
