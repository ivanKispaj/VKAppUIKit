//
//  ModelToCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit

//MARK: - Model для отображения страницы новостей


enum CellType: String {
    case photo = "photo"
    case link = "link"
    case video = "video"
    case post = "post"
    case gallary = "gallary"
    case photoLink
    case uncnown = "uncnown"
}

enum VideoType  {
    case live
    case video
}

struct NewsCellData {
    var ownerId: Int = 0
    var date: Double = 0
    var newsLikeCount: Int = 0
    var newsLikeStatus = false
    var newsSeenCount: Int = 0
    var isOnline = false
    var isBanned = false
    var newsUserName: String = ""
    var newsUserLogo: Data!
    var videoId: Int = 0
    var albumId: Int = 0
    var newsText: String = ""
    var newsLink: String = ""
    var newsDescription: String = ""
    var newsImage: [PhotoDataNews] = []
    var firstFrame: PhotoDataNews!
    var trackCode: String = ""
    var accessKey: String = ""
    var lableOnPhoto: String = ""
    var lableUserNameOnPhoto: String = ""
    var videoType: VideoType = .video
}



struct NewsUserData {
    let userLogo: Data
    let userName: String
    let isOnline: Bool
    let isBanned: Bool
    let screenName: String
    
}

struct PhotoDataNews {
    var url: String
    var height: CGFloat
    var width: CGFloat
}

