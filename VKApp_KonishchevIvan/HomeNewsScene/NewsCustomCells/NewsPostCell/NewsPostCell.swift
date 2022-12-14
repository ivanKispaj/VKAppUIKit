//
//  NewsPostCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 26.05.2022.
//

import UIKit

class NewsPostCell: UITableViewCell, DequeuableProtocol {

    
    @IBOutlet weak var newsPostUserAvatar: UIImageView!
    
    
    @IBOutlet weak var newsPostTextLabel: UILabel!
    
    @IBOutlet weak var newsPostSeenCount: UILabel!
    @IBOutlet weak var newsPostLikeCount: UILabel!
    @IBOutlet weak var newsPostLikeHeart: UIImageView!
    @IBOutlet weak var newsPostUserSeen: UILabel!
    @IBOutlet weak var newsPostUserName: UILabel!
    
    func configureCellForPost(from data: NewsCellData) {
                   self.newsPostTextLabel.text = data.newsText
                   self.newsPostUserName.text = data.newsUserName
                   self.newsPostUserSeen.text = data.date.unixTimeConvertion()
                   self.newsPostLikeCount.text = String(data.newsLikeCount)
                   self.newsPostSeenCount.text = String(data.newsSeenCount)
                   self.newsPostUserAvatar.image = UIImage(data: data.newsUserLogo)
    }
}
