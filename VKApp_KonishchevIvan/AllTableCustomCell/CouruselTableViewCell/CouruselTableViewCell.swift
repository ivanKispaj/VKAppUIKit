//
//  CouruselTableViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit


class CouruselTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, DequeuableProtocol {

    @IBOutlet var CouruselCollection: UICollectionView!
    var collectionData: [Friend]! {
        didSet {
            CouruselCollection.reloadData()
        }
    }
    
    
    weak var delegate: TableViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.CouruselCollection.dataSource = self
        self.CouruselCollection.delegate = self
        self.CouruselCollection.register(CouruselCollectionViewCell.self)
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.collectionData?.count ?? 0
         
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell: CouruselCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
         cell.imageCouruselCell.loadImageFromUrlString(self.collectionData![indexPath.row].photo)
         cell.lableForDetailsCorusel.text = self.collectionData![indexPath.row].userName
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        print("select: \(self.collectionData![indexPath.row].id)")

        
    }
    

}
