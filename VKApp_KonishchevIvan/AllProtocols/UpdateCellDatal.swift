//
//  UpdateCellData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 03.07.2022.
//

import UIKit

protocol UpdateCellData: AnyObject {

    func updateCellData(with indexPath: IndexPath, textHeight: CGFloat, togle: Bool)
}
 
