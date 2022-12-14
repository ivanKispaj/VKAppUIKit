//
//  NewGroupSearchModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

struct NewGroupSearchModel: Decodable {
    let response: NewGroupResponse
}

struct NewGroupResponse: Decodable {
    let items: [Items]
}

struct  Items: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case groupName = "name"
        case photoGroup = "photo_50"
        case activity = "screen_name"
    }
    var activity: String?
    var id: Int
    var groupName: String
    var photoGroup: String
}
