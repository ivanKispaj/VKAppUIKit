//
//  TableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.04.2022.
//

import UIKit

class LinkTableViewCell: UITableViewCell, DequeuableProtocol {

    @IBOutlet weak var linkUserLogo: UIImageView!
    @IBOutlet weak var linkUserName: UILabel!
    @IBOutlet weak var linkDate: UILabel!
    @IBOutlet weak var linkLink: UILabel!
    @IBOutlet weak var linkText: UILabel!
    @IBOutlet weak var linkCaption: UILabel!
    
    @IBOutlet weak var linkSeenCount: UILabel!
    @IBOutlet weak var linkLikeHeart: UIImageView!
    @IBOutlet weak var linkLikeCount: UILabel!
    @IBOutlet weak var linkViewLike: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.linkViewLike.layer.cornerRadius = 20
    }

    func setCellData(from data: DetailsSectionData, to friend: Friend) {
        
        self.linkCaption.text = data.captionNews
        self.linkDate.text = data.date.unixTimeConvertion()
        self.linkLink.text = data.linkUrl
        self.linkLikeCount.text = String(data.likes.count)
        self.linkUserLogo.loadImageFromUrlString(friend.photo)
        self.linkUserName.text = friend.userName
        self.linkText.text = data.titleNews
        self.linkSeenCount.text = String(data.views?.count ?? 0)
    }
}
