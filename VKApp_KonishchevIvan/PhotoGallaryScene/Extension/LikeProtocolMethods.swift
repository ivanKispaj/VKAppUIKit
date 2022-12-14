//
//  LikeProtocolMethods.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 22.04.2022.
//

import UIKit

//MARK: - Animation delegate
extension GallaryViewController  {
    //MARK: - ProtocolLikeDelegate methods
    
    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        let like = [self.arrayPhoto[indexPath.row].likeLabel : self.arrayPhoto[indexPath.row].likeStatus]
        return like
    }
    
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        self.arrayPhoto[indexPath.row].likeLabel = countLike
        self.arrayPhoto[indexPath.row].likeStatus = likeStatus
        self.setLikeData()
    }
    private func setLikeData() {
        if self.arrayPhoto[self.currentImage].likeStatus {
            self.heartImageView.image = UIImage(systemName: "suit.heart.fill")
            self.heartImageView.tintColor = UIColor.red
        } else {
            self.heartImageView.image = UIImage(systemName: "suit.heart")
            self.heartImageView.tintColor = UIColor.systemGray2
        }
        self.labelLikeView.text = String(self.arrayPhoto[self.currentImage].likeLabel)
        self.controllForLike.indexPath = IndexPath(row: self.currentImage, section: 0)
    }
}
