//
//  DelegateLikeExtension.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 22.04.2022.
//

import UIKit

// MARK: - методы для делегата like controll !!
extension HomeNewsTableViewController: LikeDelegate {

    func getCountLike(for indexPath: IndexPath) -> [Int : Bool] {
        return  [0: false]
    }

    
// В процессе доработки!!
    func setCountLike(countLike: Int, likeStatus: Bool, for indexPath: IndexPath) {
        
    }
}
