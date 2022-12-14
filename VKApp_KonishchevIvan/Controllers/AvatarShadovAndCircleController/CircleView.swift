//
//  NewsAuthorAvatar.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 14.03.2022.
//

import UIKit

class CircleView: UIView {
    
    override func layoutSubviews() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = bounds.height/2
    }
    
}
