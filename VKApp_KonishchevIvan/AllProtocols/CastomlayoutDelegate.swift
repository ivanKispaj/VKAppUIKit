//
//  CastomlayoutDelegate.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 01.04.2022.
//

import UIKit

protocol CastomlayoutDelegate: AnyObject {
    func setLikeData(numberImage: Int)
    func collectionView(_ collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, withWidth width: CGFloat) -> CGSize
}
