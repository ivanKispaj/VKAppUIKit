//
//  AllNewUserGroups.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation


struct AllNewUserGroups:Equatable {
    let id: Int
    let nameGroup: String
    let imageGroup: String
    let activity: String
    
    init(id: Int, nameGroup: String, logoGroup: String, activity: String ) {
        self.id = id
        self.nameGroup = nameGroup
        self.imageGroup = logoGroup
        self.activity = activity
    }
}
