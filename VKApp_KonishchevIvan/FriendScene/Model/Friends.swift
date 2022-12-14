//
//  Friends.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.02.2022.
//

import UIKit
import RealmSwift


final class Friend {
    var countFriends = 0
    var userName: String = ""
    var photo: String = ""
    var id: Int = 0
    var city: String = ""
    var lastSeenDate: Double = 0
    var isClosedProfile: Bool = false
    var isBanned: Bool = false
    var online: Bool = false
    var status: String = " "
    
    
}

struct Friends: Decodable {
    let response: FriendsResponse
    
}

final class FriendsResponse: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case items
        case countFriends = "count"
    }
    @objc dynamic var id = 0
    @objc dynamic var countFriends = 0
    dynamic var items = List<FriendsItems>()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let user = decoder.userInfo.first { $0.key.rawValue == "ownerId" }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode(List<FriendsItems>.self, forKey: .items)
        countFriends = try container.decode(Int.self, forKey: .countFriends)
        id = user?.value as! Int
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}


//MARK: - Realm Model
final class FriendsItems: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case city
        case fName = "first_name"
        case lName = "last_name"
        case photo50 = "photo_50"
        case id
        case online
        case lastSeen = "last_seen"
        case isClosedProfile = "is_closed"
        case banned = "deactivated"
        case status
        
    }
    
    @objc dynamic var photo50: String = ""
    @objc dynamic var city: City? = nil
    @objc dynamic var fName: String = ""
    @objc dynamic var lName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var online: Int = 0
    @objc dynamic var lastSeen: LastSeen? = nil
    @objc dynamic var isClosedProfile: Bool = false
    @objc dynamic var banned: String? = nil
    @objc dynamic var status: String? = nil
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photo50 =  try container.decode(String.self, forKey: .photo50)
        city = try? container.decodeIfPresent(City.self, forKey: .city)
        fName = try container.decode(String.self, forKey: .fName)
        lName = try container.decode(String.self, forKey: .lName)
        id = try container.decode(Int.self, forKey: .id)
        online = try container.decode(Int.self, forKey: .online)
        lastSeen = try? container.decodeIfPresent(LastSeen.self, forKey: .lastSeen) ??
        nil
        
        isClosedProfile = try container.decodeIfPresent(Bool.self, forKey: .isClosedProfile) ?? false
        banned = try? container.decode(String.self, forKey: .banned)
        status = try? container.decode(String.self, forKey: .status)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

final class City: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
    }
    
}

final class LastSeen: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case time
        case platform
    }
    @objc dynamic var platform: Int = 0
    @objc dynamic var time: Double = 0
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        time = try container.decode(Double.self, forKey: .time)
        platform = try container.decode(Int.self, forKey: .platform)
    }
    
}
