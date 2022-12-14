//
//  HomeNewsViewModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 16.08.2022.
//

import Foundation
import UIKit
import AVKit

struct newsVideoViewModel {
    var newsUserName: String
    var newsUserAvatar: UIImage?
    var newsVideoFrameImage: UIImage?
    var newsUserSeen: String
    var newsLikeCount: String
    var newsSeenCount: String
    var newsVideoText: String
    var player: AVPlayerViewController?
    var videoHeight: CGFloat
}

