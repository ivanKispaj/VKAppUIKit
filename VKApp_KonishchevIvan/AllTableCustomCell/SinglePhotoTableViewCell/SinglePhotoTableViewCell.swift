//
//  SinglePhotoTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class SinglePhotoTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, DequeuableProtocol {

    private var photoService: PhotoCacheService?
    @IBOutlet weak var likeControll: ControlForLike!
    
    @IBOutlet weak var singlCollection: UICollectionView!
    @IBOutlet weak var singleLableUserName: UILabel!
    @IBOutlet weak var singleAvatarHeader: UIImageView!
    @IBOutlet weak var singleAdditionalInfo: UILabel!
    @IBOutlet weak var singlPhotoLikeLable: UILabel!
    @IBOutlet weak var singlePhotoLikeImage: UIImageView!
    @IBOutlet weak var singlePhotoSeenCount: UILabel!
    
    var delegateIndexPatch: IndexPath!
    var singlePhoto: ImageAndLikeData! {
        didSet {
            self.singlCollection.reloadData()
        }
    }
   weak var delegate: TableViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.singlCollection.delegate = self
        self.singlCollection.dataSource = self
        self.singlCollection.register(SingleCollectionViewCell.self)
        self.photoService = PhotoCacheService(container: self.singlCollection)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if singlePhoto != nil {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SingleCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let image = photoService?.photo(atIndexPath: indexPath, byUrl: self.singlePhoto.image)
        cell.singlePhoto.image = image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        let photo  = [self.singlePhoto!] 
        self.delegate.selectRow(nextViewData: photo, indexPath: self.delegateIndexPatch)
    }


    func setCellData(from data: DetailsSectionData, to user: Friend) {
//        if user.photo == nil {
//            self.singleAvatarHeader.image = UIImage(named: "noFoto")
//
//        } else {
//            self.singleAvatarHeader.image = UIImage(data: user.photo)
//
//        }
            self.singleAvatarHeader.loadImageFromUrlString(user.photo) 
        self.singleLableUserName.text = user.userName
        if let seen = data.views {
            self.singlePhotoSeenCount.text = String(seen.count)
        } else {
            self.singlePhotoSeenCount.text = "0"
        }
        var photo =  data.photo![self.delegateIndexPatch.row]
        photo.likeLabel = data.likes.count
        
        self.singlePhoto = photo
        self.singlPhotoLikeLable.text = String(data.likes.count)
        self.singlePhotoSeenCount.text = String(data.views?.count ?? 0)
    }
}
