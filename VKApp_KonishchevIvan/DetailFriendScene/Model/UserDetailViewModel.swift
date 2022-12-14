//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

enum SectionType {
    case Friends
    case Gallary
    case SingleFoto
    case link
    case linkPhoto
    case video
    case newsText
    case unknown
    
}

struct UserDetailsTableData {
    
    let sectionType: SectionType
    var sectionData: DetailsSectionData
    
}

struct DetailsSectionData {
    var friensCount = 0
    var id: Int = 0
    var ownerId: Int = 0
    var date: Double = 0
    var textNews: String = ""
    var likes: WallLikes = WallLikes()
    var views: WallViews? = nil
    var urlNewsImage: String? = nil
    var titleNews: String? = nil
    var captionNews: String? = nil
    var friends: [Friend]? = nil
    var photo: [ImageAndLikeData]? = nil
    var linkUrl:  String? = nil
    init() {}
    init( id: Int, ownerId: Int, date: Double, textNews: String, likes: WallLikes, views: WallViews?, urlNewsImage: String?, titleNews: String?, captionNews: String?, link: String ) {
        self.id = id
        self.ownerId = ownerId
        self.date = date
        self.textNews = textNews
        self.likes = likes
        self.views = views
        self.urlNewsImage = urlNewsImage
        self.titleNews = titleNews
        self.captionNews = captionNews
        self.linkUrl = link
        
    }
    
    init(friends: [Friend], friendsCount: Int ) {
        self.friends = friends
        self.friensCount = friendsCount
    }
    
    init( photo: [ImageAndLikeData]) {
        self.photo = photo
    }
}
