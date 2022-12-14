//
//  CouruselCollectionViewCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.03.2022.
//

import UIKit

class CouruselCollectionViewCell: UICollectionViewCell, DequeuableProtocol {

    @IBOutlet weak var contentCollectionCell: UIView!
    @IBOutlet weak var avatarCouruselView: UIView!
    @IBOutlet weak var imageCouruselCell: UIImageView!
    @IBOutlet weak var lableForDetailsCorusel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentCollectionCell.layer.backgroundColor = UIColor.systemGray6.cgColor
        lableForDetailsCorusel.textColor = UIColor.appColor(.appBlackWite)// UIColor(named: "AppBW")

    }
}
