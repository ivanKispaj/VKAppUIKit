//
//  ExtendTableUserCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 07.03.2022.
//

import UIKit

class ExtendTableUserCell: UITableViewCell, DequeuableProtocol {

    @IBOutlet weak var ExtendImageCell: UIImageView!
    @IBOutlet weak var ExtendLabelCity: UILabel!
    @IBOutlet weak var ExtendLabelName: UILabel!
    
    
    func setCelldata(from data: Friend) {
        self.ExtendImageCell.image = UIImage(named: "vkLogo")
        self.ExtendLabelCity.text = data.city
        self.ExtendLabelName.text = data.userName
        self.isSelected = false
    }
}
