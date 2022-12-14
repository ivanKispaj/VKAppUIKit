//
//  LoadNewGroupList.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit
extension NewGroupTableViewController {
    func LoadNewGroupList(searchText text: String) {
        let internetConnectiopn = InternetConnectionProxy(internetConnection: InternetConnections(host: "api.vk.com", path: UrlPath.searchGroup))
        DispatchQueue.global(qos: .userInteractive).async {
            
            internetConnectiopn.getNewGroupList(for: text) { [weak self] response in
                switch response {
                    
                case .success(let result):
                    var group: [AllNewUserGroups] = []
                    for items in result.response.items {
                        if let activity = items.activity {
                            
                            
                            let res = AllNewUserGroups(id: items.id, nameGroup: items.groupName, logoGroup: items.photoGroup, activity: activity)
                            group.append(res)
                        }else {
                            let res = AllNewUserGroups(id: items.id, nameGroup: items.groupName, logoGroup: items.photoGroup, activity: "")
                            group.append(res)
                        }
                        
                    }
                    self!.allGroups = group
                case .failure(_):
                    print("ErrorLoadUserGroupFromVK")
                }
            }
        }
    }
}
