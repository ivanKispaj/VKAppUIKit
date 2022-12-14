//
//  NewsData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit
import RealmSwift


//MARK: -  Модель для парсинга новостей и сохранения в Realm !!!!
struct NewsDataModel:Decodable {
    let response: NewsResponse // response
}

final class NewsResponse: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
    }
    @objc dynamic var id = 0
    dynamic var items = List<NewsItems>() // items
    dynamic var profiles = List<NewsProfiles>() //profiles
    dynamic var  groups = List<NewsGroups>() //groups
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode(List<NewsItems>.self, forKey: .items)
        profiles = try container.decode(List<NewsProfiles>.self, forKey: .profiles)
        groups = try container.decode(List<NewsGroups>.self, forKey: .groups)
        
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}

//MARK: -  items data model
final class NewsItems: Object, Decodable{
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"  // id profiles or (Groups with  -sours_id )
        case date                   // дата
        case attachments            // опционально либо copy_history вместо него
        case newsCopyHistory = "copy_history"
        case postId = "post_id"
        case type
        case likes
        case views
        case text
        case wallPhotos = "photos"
    }
    @objc dynamic var sourceId: Int = 0
    @objc dynamic var date: Double = 0
    dynamic var attachments = List<NewsAttachments>()
    dynamic var newsCopyHistory = List<NewsCopyHistory>()
    @objc dynamic var postId: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var likes: NewsLikes? = nil
    @objc dynamic var views: NewsViews? = nil
    @objc dynamic var text: String? = nil
    @objc dynamic var wallPhotos: NewsWallPhotos? = nil
    
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sourceId = try container.decode(Int.self, forKey: .sourceId)
        date = try container.decode(Double.self, forKey: .date)
        postId = try container.decode(Int.self, forKey: .postId)
        type = try container.decode(String.self, forKey: .type)
        text = try? container.decodeIfPresent(String.self, forKey: .text)
        likes = try? container.decode(NewsLikes.self, forKey: .likes)
        views = try? container.decode(NewsViews.self, forKey: .views)
        attachments = try container.decodeIfPresent(List<NewsAttachments>.self, forKey: .attachments) ?? List<NewsAttachments>()
        newsCopyHistory = try container.decodeIfPresent(List<NewsCopyHistory>.self, forKey: .newsCopyHistory) ?? List<NewsCopyHistory>()
        wallPhotos = try? container.decode(NewsWallPhotos.self, forKey: .wallPhotos)
    }
    
}
//MARK: -  NewsAttachments ( attachments )
final class NewsAttachments: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case type
        case photoData = "photo"
        case link
        case video
    }
    @objc dynamic var type: String  = ""
    
    @objc dynamic var photoData: NewsPhotosData?
    @objc dynamic var link: NewsLink?
    @objc dynamic var video: NewsVideo?
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        photoData = try? container.decode(NewsPhotosData.self, forKey: .photoData)
        link = try? container.decode(NewsLink.self, forKey: .link)
        video = try? container.decode(NewsVideo.self, forKey: .video)
    }
    
}


//MARK: - NewsCopyHistory  ( copyHistory )
final class NewsCopyHistory: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case ownerId = "owner_id"
        case date
        case attachments
    }
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var date: Int = 0
    dynamic var attachments = List<NewsAttachments>()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ownerId = try container.decodeIfPresent(Int.self, forKey: .ownerId) ?? 0
        date = try container.decode(Int.self, forKey: .date)
        attachments = try container.decodeIfPresent(List<NewsAttachments>.self, forKey: .attachments) ?? List<NewsAttachments>()
    }
    
}



final class NewsWallPhotos: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case items
    }
    dynamic var items = List<NewsWallPhotoData>()
    
}

// MARK: - NewsWallPhotoData
final class NewsWallPhotoData: Object, Decodable {
    enum CodingKeys: String, CodingKey  {
        case albumId = "album_id"
        case date
        case idPhoto = "id"
        case photo = "sizes"
        case text
        case likes
    }
    @objc dynamic var albumId: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var idPhoto: Int = 0
    dynamic var photo = List<ImageArray>()
    @objc dynamic var likes: NewsLikes? = nil
    @objc dynamic var text: String = ""
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try container.decode(Int.self, forKey: .albumId)
        date = try container.decode(Int.self, forKey: .date)
        idPhoto = try container.decode(Int.self, forKey: .idPhoto)
        likes = try? container.decode(NewsLikes.self, forKey: .likes)
        text = try container.decode(String.self, forKey: .text)
        photo = try container.decodeIfPresent(List<ImageArray>.self, forKey: .photo) ?? List<ImageArray>()
    }
    
}

//MARK: - NewsHistoryAttachments

final class NewsHistoryAttachments: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case video
    }
    @objc dynamic var video: NewsHistoryVideo? = nil
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let contaioner = try decoder.container(keyedBy: CodingKeys.self)
        video = try? contaioner.decode(NewsHistoryVideo.self, forKey: .video)
    }
}

final class NewsHistoryVideo: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case accesKey = "access_key"
        case date
        case historyDescription = "description"
        case duration
        case newsImage = "image"
        case title
        
    }
    @objc dynamic var accesKey: String? = nil
    @objc dynamic var date: Int = 0
    @objc dynamic var historyDescription: String = ""
    @objc dynamic var duration: Int = 0
    dynamic var newsImage = List<NewsImage>()
    @objc dynamic var title: String = ""
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accesKey = try? container.decodeIfPresent(String.self, forKey: .accesKey)
        date = try container.decode(Int.self, forKey: .date)
        historyDescription = try container.decode(String.self, forKey: .historyDescription)
        duration = try container.decodeIfPresent(Int.self, forKey: .duration) ?? 0
        newsImage = try container.decodeIfPresent(List<NewsImage>.self, forKey: .newsImage) ?? List<NewsImage>()
        title = try container.decode(String.self, forKey: .title)
        
    }
}

final class NewsImage: Object, Decodable {
    @objc dynamic var url: String
    @objc dynamic var width: Int
    @objc dynamic var height: Int
}


// MARK: - NewsViews
final class NewsViews: Object, Decodable {
    enum CodingKeys: String, CodingKey{
        case count
    }
    @objc dynamic var count: Int = 0
}

//MARK: - NewsVideo
final class NewsVideo: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case image
        case title
        case accessKey = "access_key"
        case firstFrame = "first_frame"
        case trackCode = "track_code"
        case videoId = "id"
        case type
    }
    dynamic var image = List<NewsImage>()
    @objc dynamic var title: String? = nil
    @objc dynamic var accessKey: String? = nil
    dynamic var firstFrame = List<NewsVideoFirstFrame>()
    @objc dynamic var trackCode: String? = nil
    @objc dynamic var videoId: Int = 0
    @objc dynamic var type: String = ""
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decodeIfPresent(List<NewsImage>.self, forKey: .image) ?? List<NewsImage>()
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        accessKey = try? container.decodeIfPresent(String.self, forKey: .accessKey)
        firstFrame = try container.decodeIfPresent(List<NewsVideoFirstFrame>.self, forKey: .firstFrame) ?? List<NewsVideoFirstFrame>()
        trackCode = try? container.decodeIfPresent(String.self, forKey: .trackCode)
        videoId = try container.decode(Int.self, forKey: .videoId)
        type = try container.decode(String.self, forKey: .type)
    }
}

//MARK: - NewsvideoFirstFrame
final class NewsVideoFirstFrame: Object ,Decodable {
    @objc dynamic var url: String
    @objc dynamic var height: Int
    @objc dynamic var width: Int
    
}
//MARK: - NewsLink
final class NewsLink: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case caption
        case LinkDescription = "description"
        case photo
    }
    
    @objc dynamic var url: String
    @objc dynamic var title: String
    @objc dynamic var caption: String? = nil
    @objc dynamic var LinkDescription: String
    @objc dynamic var photo: NewsPhotosData?
    @objc dynamic var postSource: String? = nil
    convenience init(form decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        caption = try container.decodeIfPresent(String.self, forKey: .caption) ?? nil
        LinkDescription = try container.decode(String.self, forKey: .LinkDescription)
        photo = try? container.decode(NewsPhotosData.self, forKey: .photo)
    }
}


//MARK: - NewsPhotosData

final class NewsPhotosData: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case date
        case id
        case ownerId = "owner_id"
        case text
        case photoArray = "sizes"
    }
    @objc dynamic var albumId: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var text: String = ""
    dynamic var photoArray = List<ImageArray>()
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try container.decode(Int.self, forKey: .albumId)
        date = try container.decode(Int.self, forKey: .date)
        id = try container.decode(Int.self, forKey: .id)
        ownerId = try container.decode(Int.self, forKey: .ownerId)
        text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        photoArray = try container.decode(List<ImageArray>.self, forKey: .photoArray)
    }
    
}


//MARK: - ImageArray
final class ImageArray: Object, Decodable {
    
    @objc dynamic var height: Int
    @objc dynamic var width: Int
    @objc dynamic var url: String
    @objc dynamic var type: String
    
}


//MARK: - NewsLikes
final class NewsLikes: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case likeStatus = "user_likes"
    }
    @objc dynamic var count: Int = 0
    @objc dynamic var likeStatus: Int = 0
}

//MARK: - profiles профили пользователей оставивших новость!
final class NewsProfiles: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case fName = "first_name"
        case lName = "last_name"
        case photo = "photo_50"
        case screenName = "screen_name"
        case online
        case onlineInfo = "online_info"
        case banned = "deactivated"
    }
    @objc dynamic var id: Int = 0
    @objc dynamic var  fName: String = ""
    @objc dynamic var  lName: String = ""
    
    @objc dynamic var  photo: Data!
    
    @objc dynamic var  screenName: String? = nil
    @objc dynamic var  online: Int = 0
    dynamic var  onlineInfo: NewsOnlineInfo? = NewsOnlineInfo()
    @objc dynamic var  banned: String? = nil
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        fName = try container.decode(String.self, forKey: .fName)
        lName = try container.decode(String.self, forKey: .lName)
        let url = try container.decode(String.self, forKey: .photo)
        photo =  try? Data(contentsOf: URL(string: url)!)
        screenName = try? container.decodeIfPresent(String.self, forKey: .screenName)
        online = try container.decode(Int.self, forKey: .online)
        onlineInfo = try? container.decodeIfPresent(NewsOnlineInfo.self, forKey: .onlineInfo) ?? NewsOnlineInfo()
        banned = try? container.decodeIfPresent(String.self, forKey: .banned)
    }
}

final class NewsOnlineInfo: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
    }
    @objc dynamic var isOnline: Bool = false
    @objc dynamic var isMobile: Bool = false
    dynamic var lastSeen: Int? = nil
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let contaioner = try decoder.container(keyedBy: CodingKeys.self)
        isOnline = try contaioner.decode(Bool.self, forKey: .isOnline)
        isMobile = try contaioner.decode(Bool.self, forKey: .isMobile)
        lastSeen = try contaioner.decodeIfPresent(Int.self, forKey: .lastSeen) ?? nil
    }
}

//MARK: - groups группы оставившие новость!
final class NewsGroups: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
        case screenName = "screen_name"
    }
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    
    @objc dynamic var photo: Data!
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let url = try container.decode(String.self, forKey: .photo)
        photo = try? Data(contentsOf: URL(string: url)!)
        screenName = try container.decode(String.self, forKey: .screenName)
    }
}


