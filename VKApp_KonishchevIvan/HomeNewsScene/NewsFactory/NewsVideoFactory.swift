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
         var newsVideoFrameImage: UIImage? = nil
         var videoHeight: CGFloat = 300
         if let frame = videoData.firstFrame {
             DispatchQueue.global(qos: .userInitiated).async {
                 videoHeight = frame.height * 0.7
                 newsVideoFrameImage = frame.url.loadImageFromUrlString()
             }
         } else {
             newsVideoFrameImage = UIImage(systemName: "photo")
         }
        
        let newsUserSeen: String = videoData.date.unixTimeConvertion()
        let newsLikeCount: String = String(videoData.newsLikeCount)
        let newsSeenCount: String = String(videoData.newsSeenCount)
        let newsVideoText: String = videoData.newsText
        let player = AVPlayerViewController()
        player.videoGravity = .resizeAspectFill
        player.showsPlaybackControls = false
        player.view.translatesAutoresizingMaskIntoConstraints = false
        
         return newsVideoViewModel(newsUserName: newsUserName, newsUserAvatar: newsUserAvatar, newsVideoFrameImage: newsVideoFrameImage, newsUserSeen: newsUserSeen, newsLikeCount: newsLikeCount, newsSeenCount: newsSeenCount, newsVideoText: newsVideoText, player: player, videoHeight: videoHeight)
    }

}
