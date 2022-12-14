//
//  TableViewDelegate.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 01.04.2022.
//

import Foundation

protocol TableViewDelegate: AnyObject {
    var nextViewData: [ImageAndLikeData] {set get}
    func selectRow(nextViewData: [ImageAndLikeData], indexPath: IndexPath)
}
