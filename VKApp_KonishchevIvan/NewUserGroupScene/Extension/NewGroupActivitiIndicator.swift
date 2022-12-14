//
//  NewGroupActivitiIndicator.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 14.05.2022.
//

import UIKit

extension NewGroupTableViewController {
    func getActivityIndicatorLoadData() {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicator.color = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.785121269)
        activityIndicator.isHidden = true
        activityIndicator.style = .large
        activityIndicator.contentMode = .scaleToFill
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        self.activityIndicator = activityIndicator
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ])
    }
}
