//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 20.03.2022.
//

import UIKit
import RealmSwift

struct ImageAndLikeData {
    var image: String
    var likeStatus: Bool = false
    var likeLabel: Int = 0
    var height: CGFloat
    var width: CGFloat
    var seenCount: Int
    init(image: String, likeStatus: Bool, likeLabel: Int = 0, height: CGFloat, width: CGFloat, seenCount: Int) {
        self.image = image
        self.likeStatus = likeStatus
        self.likeLabel = likeLabel
        self.height = height
        self.width = width
        self.seenCount = seenCount
    }
}

struct PhotoUser: Decodable {
    let response: PhotoResponse
}

final class PhotoResponse: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case items
    }
    @objc dynamic var id = 0
    dynamic var items = List<PhotoItems>()
    convenience init(from decoder: Decoder) throws {
        self.init()
        let user = decoder.userInfo.first { $0.key.rawValue == "ownerId" }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode(List<PhotoItems>.self, forKey: .items)
        id = user?.value as! Int
    }
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

final class PhotoItems: Object, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case likes
        case date
        case photo = "sizes"
        case id
        case ownerId = "owner_id"
    }
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var date: Double = 0
    @objc dynamic var albumId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var likes: PhotoLikes? = PhotoLikes()
    dynamic var photo: List<PhotoData> = List<PhotoData>()
    
    convenience init(from decoder:  Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        date = try container.decode(Double.self, forKey: .date)
        albumId = try container.decode(Int.self, forKey: .albumId)
        id = try container.decode(Int.self, forKey: .id)
        likes = try? container.decode(PhotoLikes.self, forKey: .likes)
        photo = try container.decode(List<PhotoData>.self, forKey: .photo)
        
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}


final class PhotoData: Object, Decodable {
    
    @objc dynamic var height: Double
    @objc dynamic var width: Double
    @objc dynamic var url: String
    @objc dynamic var type: String
}

final class PhotoLikes: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
    @objc dynamic var count: Int
    @objc dynamic var userLikes: Int
}


