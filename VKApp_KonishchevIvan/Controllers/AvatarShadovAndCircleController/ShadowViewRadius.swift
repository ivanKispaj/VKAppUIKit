//
//  Customise.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 14.03.2022.
//

import UIKit

class ShadowViewRadius: UIView {
    
    @IBOutlet weak var avatarHeaightConstraint: NSLayoutConstraint!
    var shadowColor: CGColor = UIColor.appColor(.avatarShadow).cgColor//UIColor(named: "AvatarShadow")!.cgColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapToIconAvatar))
        gesture.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
        
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = bounds.height/2
        
    }
    
    
}

//MARK: - расширение добавляет анимацию при тапе на картинку!
extension ShadowViewRadius {
    
    @objc func tapToIconAvatar( _ tap: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.2) {
            self.avatarHeaightConstraint.constant = self.avatarHeaightConstraint.constant - 5
            self.layoutIfNeeded()
            
        }completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0.0,
                           usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 0.1,
                           options: .curveEaseInOut) {
                self.avatarHeaightConstraint.constant = self.avatarHeaightConstraint.constant + 5
                self.layoutIfNeeded()
            }
        }
    }
    
}
