//
//  AllUserGroups.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.02.2022.
//

import UIKit

struct AllUserGroups:Equatable {
    var nameGroup: String
    let imageGroup: Data!
    let activity: String
    let id: Int
    init(id: Int, nameGroup: String, logoGroup: Data, activity: String ) {
        self.nameGroup = nameGroup
        self.imageGroup = logoGroup
        self.activity = activity
        self.id = id
    }
}
