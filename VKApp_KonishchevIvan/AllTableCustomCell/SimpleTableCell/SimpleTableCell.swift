//
//  TableViewCellXib.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 05.03.2022.
//

import UIKit
import RealmSwift
// Макет ячейки с переменными для установки
class SimpleTableCell: UITableViewCell,DequeuableProtocol {

    @IBOutlet weak var profileStatus: UILabel!
    @IBOutlet weak var imageCellAvatar: UIImageView!
    @IBOutlet weak var lableCellXib: UILabel!
    @IBOutlet weak var labelCityCellXib: UILabel!
    
    
    func setCellData(toFriendsScene data: Friend) {
//        if let dataPhoto = data.photo {
//            self.imageCellAvatar.image = UIImage(data: dataPhoto)
//        } else {
//            self.imageCellAvatar.image = UIImage(named: "noFoto")
//        }
        self.imageCellAvatar.loadImageFromUrlString(data.photo)
        self.labelCityCellXib.text = data.city
        self.lableCellXib.text = data.userName
        self.profileStatus.text = ""
        
        if data.isBanned {
            self.profileStatus.text = "Banned!"
            self.profileStatus.tintColor = UIColor.red
        }
        
        if data.isClosedProfile {
            self.profileStatus.text = "Private"
            self.profileStatus.tintColor = UIColor.blue
        }
    }
    
    func setCellData(toGroupScene data: ItemsGroup) {
        self.imageCellAvatar.loadImageFromUrlString(data.photoGroup)
        self.lableCellXib.text = data.groupName
        self.labelCityCellXib.text = data.activity
        self.profileStatus.text = ""
    }
}
