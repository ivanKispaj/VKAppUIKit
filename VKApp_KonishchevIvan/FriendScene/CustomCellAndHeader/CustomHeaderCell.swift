//
//  CustomHeaderoCell.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 31.05.2022.
//

import UIKit

class CustomHeaderCell: UITableViewHeaderFooterView {

    let nameSection = UILabel()
    let countFriends = UILabel()
    let action = UILabel()
    
    override init(reuseIdentifier: String?) {
         super.init(reuseIdentifier: reuseIdentifier)
         configureViewContent()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewContent() {
        action.isUserInteractionEnabled = true
        nameSection.translatesAutoresizingMaskIntoConstraints = false
        countFriends.translatesAutoresizingMaskIntoConstraints = false
        action.translatesAutoresizingMaskIntoConstraints = false
        action.textColor = UIColor.appColor(.appButton)//UIColor(named: "AppButton")
        countFriends.textColor = .systemGray5
        nameSection.textColor = UIColor.appColor(.appBlackWite)// UIColor(named: "AppBW")
        action.font = UIFont.boldSystemFont(ofSize: 12)
        nameSection.font = UIFont.boldSystemFont(ofSize: 14)
        countFriends.font = UIFont.systemFont(ofSize: 10)
        countFriends.textColor = UIColor.appColor(.appBlackWite)//UIColor(named: "AppBW")
        contentView.addSubview(nameSection)
        contentView.addSubview(countFriends)
        contentView.addSubview(action)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: nameSection.leadingAnchor, constant: -5),
            nameSection.trailingAnchor.constraint(equalTo: countFriends.leadingAnchor, constant: -10),
            action.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 10),
            nameSection.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countFriends.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            action.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
