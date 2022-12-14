//
//  NewsVideoFactory.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 16.08.2022.
//

import UIKit
import AVKit
final class NewsVideoFactory {


    
     func videoModel(with videoData: NewsCellData) -> newsVideoViewModel {
        let newsUserName = videoData.newsUserName
        let newsUserAvatar: UIImage? =  UIImage(data: videoData.newsUserLogo)
        let newsVideoFrameImage: UIImage? = videoData.firstFrame.url.loadImageFromUrlString()
        let newsUserSeen: String = videoData.date.unixTimeConvertion()
        let newsLikeCount: String = String(videoData.newsLikeCount)
        let newsSeenCount: String = String(videoData.newsSeenCount)
        let newsVideoText: String = videoData.newsText
         let videoHeight = videoData.firstFrame.height * 0.7
        let player = AVPlayerViewController()
        player.videoGravity = .resizeAspectFill
        player.showsPlaybackControls = false
        player.view.translatesAutoresizingMaskIntoConstraints = false
        
         return newsVideoViewModel(newsUserName: newsUserName, newsUserAvatar: newsUserAvatar, newsVideoFrameImage: newsVideoFrameImage, newsUserSeen: newsUserSeen, newsLikeCount: newsLikeCount, newsSeenCount: newsSeenCount, newsVideoText: newsVideoText, player: player, videoHeight: videoHeight)
    }

}
