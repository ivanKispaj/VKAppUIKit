//
//  GalaryTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class GallaryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, DequeuableProtocol {
    
    @IBOutlet weak var gallaryCollection: UICollectionView!
    private var photoService: PhotoCacheService?
    
    weak var delegate: TableViewDelegate!
    weak var delegateFrameImages: SetFrameImages!
    var gallaryImageSet: [ Int: [ImageAndLikeData]] = [:]
    var gallaryData: [ImageAndLikeData]! {
        didSet {
            self.getgallaryImageSet()
            self.gallaryCollection.reloadData()
        }
    }
    var delegateIndexPath: IndexPath!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.gallaryCollection.delegate = self
        self.gallaryCollection.dataSource = self
        self.gallaryCollection.register(GallaryCollectionViewCell.self)
        self.photoService = PhotoCacheService(container: gallaryCollection)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.gallaryImageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = self.gallaryImageSet[section]?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GallaryCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.gallaryImage.contentMode = .scaleAspectFill
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 4
        guard let value = self.gallaryImageSet[indexPath.section] else {return cell}
        let image = photoService?.photo(atIndexPath: indexPath, byUrl: value[indexPath.row].image)
        cell.gallaryImage.image = image
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var frameArray: [CGRect] = []
        let currentFrame: CGRect = collectionView.cellForItem(at: indexPath)!.frame
        let visibleCells = collectionView.visibleCells
        for images in visibleCells {
            frameArray.append(images.frame)
        }
        var currentImage = 0
        switch indexPath.section {
            
        case 0:
            currentImage = indexPath.row
        case 1:
            currentImage = indexPath.row + 2
        default:
            print("IndexOutOfRange")
        }
        
        self.delegateFrameImages.setCurrentImage(currentImage)
        self.delegateFrameImages.setFrameImages(frameArray, currentFrame: currentFrame)
        self.delegate.selectRow(nextViewData: self.gallaryData, indexPath: self.delegateIndexPath)
        // Выбранная ячейка коллекции!!
        
    }
    
    private func getgallaryImageSet() {
        gallaryImageSet = [:]
        var index = 0
        var section = 0
        for i in gallaryData {
            if var set = gallaryImageSet[section] {
                set.append(i)
                gallaryImageSet[section] = set
            } else {
                gallaryImageSet[section] = [i]
            }
            index += 1
            if index == 2 {
                section += 1
            } else if index == 4 {
                break
            }
        }
    }
    
}
