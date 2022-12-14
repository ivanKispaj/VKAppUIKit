//
//  UserWallModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.04.2022.
//

import Foundation
import RealmSwift

struct UserWallModel: Decodable {
    let response: UserWallResponse
}

final class UserWallResponse: Object, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    @objc dynamic var id = 0
    dynamic var items = List<UserWallItems>()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let user = decoder.userInfo.first { $0.key.rawValue == "ownerId" }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode(List<UserWallItems>.self, forKey: .items)
        id = user?.value as! Int
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}


final class UserWallItems: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case date
        case text
        case attachments
        case likes
        case views
        case wallcopyHystory = "copy_history"
        
    }
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var date: Double = 0
    @objc dynamic var text: String = ""
    dynamic var attachments = List<WallAttachments>()
    dynamic var wallcopyHystory = List<WallCopyHistory>()
    @objc dynamic var likes: WallLikes? = WallLikes()
    @objc dynamic var views: WallViews? = WallViews()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        date = try container.decode(Double.self, forKey: .date)
        text = try container.decode(String.self, forKey: .text)
        attachments = try container.decodeIfPresent(List<WallAttachments>.self, forKey: .attachments) ?? List<WallAttachments>()
        wallcopyHystory = try container.decodeIfPresent(List<WallCopyHistory>.self, forKey: .wallcopyHystory) ?? List<WallCopyHistory>()
        likes = try container.decodeIfPresent(WallLikes.self, forKey: .likes) ?? nil
        views = try container.decodeIfPresent(WallViews.self, forKey: .views) ?? nil
        
    }
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

final class WallCopyHistory: Object,  Decodable {
    enum CodingKeys: String, CodingKey {
        case attachments
    }
    dynamic var attachments = List<WallAttachments>()
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        attachments = try container.decodeIfPresent(List<WallAttachments>.self, forKey: .attachments) ?? List<WallAttachments>()
    }
    
}
final class WallAttachments: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case photo
        case link
    }
    @objc dynamic var type: String = ""
    @objc dynamic var photo: WallPhoto? = WallPhoto()
    @objc dynamic var link: WallLink? = WallLink()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        photo = try container.decodeIfPresent(WallPhoto.self, forKey: .photo) ?? nil
        link = try container.decodeIfPresent(WallLink.self, forKey: .link) ?? nil
        
    }
    
}

final class WallLink: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case caption
        case photo
    }
    @objc dynamic var url: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var caption: String = ""
    @objc dynamic var photo: WallPhoto? = WallPhoto()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? ""
        photo = try container.decodeIfPresent(WallPhoto.self, forKey: .photo) ?? nil
    }
}
final class WallPhoto: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case date
        case photoId = "id"
        case ownerId = "owner_id"
        case sizes
    }
    @objc dynamic var albumId: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var photoId: Int = 0
    @objc dynamic var ownerId: Int = 0
    dynamic var sizes = List<WallSizes>()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try container.decodeIfPresent(Int.self, forKey: .albumId) ?? 0
        date = try container.decode(Int.self, forKey: .date)
        photoId = try container.decode(Int.self, forKey: .photoId)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        sizes = try container.decode(List<WallSizes>.self, forKey: .sizes)
    }
    
}
final class WallSizes: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case url
        case type
    }
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
        url = try container.decode(String.self, forKey: .url)
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
    }
}
final class WallLikes: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case userLike = "user_likes"
    }
    @objc dynamic var count: Int
    @objc dynamic var userLike: Int
}

final class WallViews: Object, Decodable {
    @objc dynamic var count: Int
}

