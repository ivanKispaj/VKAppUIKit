//
//  extensionUITableView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 24.05.2022.
//
// Расширения для изменения создания кастомных view при действиях с ячейками!
import UIKit

extension UITableView {
    
    public func customzeSwipeView(for tableView: UITableView) {
        var color: UIColor!
        for subview in self.subviews {
            guard NSStringFromClass(type(of: subview)) == "_UITableViewCellSwipeContainerView" else {
                continue
            }
            subview.backgroundColor = .clear
            for swipeContainerSubview in subview.subviews {
                guard NSStringFromClass(type(of: swipeContainerSubview)) == "UISwipeActionPullView" else {
                    continue
                }
                swipeContainerSubview.backgroundColor = .clear
                for (_, view) in swipeContainerSubview.subviews.enumerated() {
                    //btnView -> сама кнопка
                    if let btnView: UIButton = view as? UIButton {
                        
                        btnView.layer.masksToBounds = true
                        btnView.layer.cornerRadius = 10
                        
                        for (index,btnViews) in btnView.subviews.enumerated() {
                            if let btnImageView = btnViews as? UIImageView {
                                
                                // btnViews and btnImageview -> это UIImageView
                                btnViews.removeFromSuperview()
                                let imageView = UIImageView(frame: btnImageView.frame)
                                imageView.image = btnImageView.image
                                let label = UILabel(frame: .zero)
                                if let text = btnView.titleLabel?.text, btnImageView.image != nil {
                                    label.text = text
                                    btnView.titleLabel?.isHidden = true
                                    label.sizeToFit()
                                    label.font = UIFont.systemFont(ofSize: 10.0)
                                    btnView.addSubview(imageView)
                                    btnView.addSubview(label)
                                    
                                    
                                    imageView.backgroundColor = .clear
                                    
                                    if index == 0 {
                                        switch btnViews.backgroundColor! {
                                        case .red:
                                            
                                            color = .black
                                        case .blue:
                                            color = .white
                                        case .clear:
                                            btnViews.backgroundColor = .red
                                        default:
                                            color = .black
                                        }
                                    }
                                    label.textColor = color
                                    imageView.tintColor = .black
                                    
                                    label.translatesAutoresizingMaskIntoConstraints = false
                                    btnViews.translatesAutoresizingMaskIntoConstraints = false
                                    imageView.translatesAutoresizingMaskIntoConstraints = false
                                    
                                    NSLayoutConstraint.activate([
                                        imageView.centerXAnchor.constraint(equalTo: btnView.centerXAnchor),
                                        imageView.heightAnchor.constraint(equalToConstant: 20),
                                        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0/1.0),
                                        imageView.topAnchor.constraint(equalTo: btnView.topAnchor, constant: 4),
                                        imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: 2),
                                        label.centerXAnchor.constraint(equalTo: btnView.centerXAnchor),
                                        label.bottomAnchor.constraint(greaterThanOrEqualTo: btnView.bottomAnchor, constant: 0)
                                    ])
                                }
                                
                                if label.text == "Выйти"  {
                                    imageView.tintColor = .red
                                    DispatchQueue.main.async {
                                        label.layer.opacity = 0
                                        imageView.layer.opacity = 0
                                        label.layer.position.y += 8
                                        UIImageView.animate(withDuration: 1,
                                                            delay: 0,
                                                            options: .curveLinear) {
                                            imageView.layer.opacity = 1
                                            label.layer.opacity = 1
                                            label.layer.position.y -= 8
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                    } else {
                        view.layer.masksToBounds = true
                        view.layer.backgroundColor = UIColor.clear.cgColor
                        view.layer.cornerRadius = 10
                    }
                    
                }
                
            }
        }
    }
}


