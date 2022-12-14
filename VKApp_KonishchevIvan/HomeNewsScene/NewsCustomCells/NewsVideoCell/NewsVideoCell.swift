//
//  NewsVideoCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit
import AVKit
import AVFoundation

class NewsVideoCell: UITableViewCell, DequeuableProtocol {
    
    @IBOutlet weak var newsUserName: UILabel!
    @IBOutlet weak var newsUserAvatar: UIImageView!
    @IBOutlet weak var videoUIView: UIView!
    @IBOutlet weak var newsVideoFrameImage: UIImageView!
    @IBOutlet weak var newsUserSeen: UILabel!
    @IBOutlet weak var newsLikeCount: UILabel!
    @IBOutlet weak var newsSeenCount: UILabel!
    @IBOutlet weak var newsVideoText: UILabel!
    @IBOutlet weak var newsVideoHeightConstraint: NSLayoutConstraint!
    
    var playerViewController: AVPlayerViewController!
    var videoData: newsVideoViewModel? {
        didSet {
            self.configureCellForVideo()
        }
    }
    
    private func configureCellForVideo() {
        guard let data = self.videoData else { return }
        self.newsVideoText.font = UIFont.systemFont(ofSize: 12)
        self.newsVideoText.text = data.newsVideoText
        self.newsUserName.text = data.newsUserName
        self.newsUserSeen.text = data.newsUserSeen
        self.newsLikeCount.text = data.newsLikeCount
        self.newsSeenCount.text = data.newsSeenCount
        let videoHeight = data.videoHeight
        self.newsVideoHeightConstraint.constant = videoHeight
        self.playerViewController = data.player
        self.setVideoPlayerController()
    }
    
    private func setVideoPlayerController() {
        
        self.videoUIView.addSubview(self.playerViewController.view)
        
        NSLayoutConstraint.activate([
            playerViewController.view.leadingAnchor.constraint(equalTo: self.videoUIView.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: self.videoUIView.trailingAnchor),
            playerViewController.view.topAnchor.constraint(equalTo: self.videoUIView.topAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: self.videoUIView.bottomAnchor)
        ])
        
    }
    
}







