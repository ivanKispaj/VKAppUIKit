//
//  ControlForLike.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit


class ControlForLike: UIControl {
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeLable: UILabel!
    
    weak var delegate: LikeDelegate!
    var indexPath: IndexPath!
    var indexForGallary: Int = 0
    var isLike: Bool = false
    var counLikes: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(setLike))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
    @objc func setLike(_ tap: UITapGestureRecognizer) {
        
        // Получаем количество лайков по текущему индекс патч!
        
        let like = delegate.getCountLike(for: self.indexPath)
        for (key, value) in like {
            self.counLikes = key
            self.isLike = value
        }
        
        if self.isLike {
            
            UIImageView.animate(withDuration: 0.5) {
                self.likeImage.layer.position.y -= 5
                self.likeImage.layer.opacity = 0
                
            }
            UIImageView.animate(withDuration: 0.5,
                                delay: 0.0,
                                usingSpringWithDamping: 0.2,
                                initialSpringVelocity: 0.1,
                                options: .curveLinear ) {
                self.likeImage.layer.opacity = 1
                self.likeImage.layer.position.y += 5
                self.likeImage.image = UIImage(systemName: "suit.heart")
                self.likeImage.tintColor = UIColor.systemGray2
            }
            self.counLikes -= 1
        } else {
            UIImageView.animate(withDuration: 0.5) {
                self.likeImage.layer.position.y -= 5
                self.likeImage.layer.opacity = 0
            }
            UIImageView.animate(withDuration: 0.5,
                                delay: 0.0,
                                usingSpringWithDamping: 0.2,
                                initialSpringVelocity: 0.1,
                                options: .curveLinear) {
                self.likeImage.layer.opacity = 1
                self.likeImage.layer.position.y += 5
                self.likeImage.image = UIImage(systemName: "suit.heart.fill")
                
                self.likeImage.tintColor = UIColor.red
            }
            self.counLikes += 1
        }
        self.isLike.toggle()
        self.likeLable.text = String(self.counLikes)
        delegate.setCountLike(countLike: self.counLikes, likeStatus: self.isLike, for: self.indexPath)
        
    }
}
