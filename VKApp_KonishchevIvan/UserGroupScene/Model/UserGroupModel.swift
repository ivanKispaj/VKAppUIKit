//
//  UserGroupModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import Foundation
import RealmSwift

struct UserGroupModel: Decodable {
    let response: GroupResponse
}

struct GroupResponse: Decodable {
    let items: [ItemsGroup]
}

final class ItemsGroup: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case activity = "activity"
        case id
        case groupName = "name"
        case isClosed = "is_closed"
        case photoGroup = "photo_50"
    }
    @objc dynamic var activity: String? = nil
    @objc dynamic var id: Int = 0
    @objc dynamic var groupName: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var photoGroup: String = ""
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activity = try container.decodeIfPresent(String.self, forKey: .activity) ?? nil
        id = try container.decode(Int.self, forKey: .id)
        groupName = try container.decode(String.self, forKey: .groupName)
        isClosed = try container.decode(Int.self, forKey: .isClosed)       
        self.photoGroup =  try container.decode(String.self, forKey: .photoGroup)
        
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}

