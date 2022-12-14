//
//  CustomCodeSearchBar.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 29.03.2022.
//
// Достаточно добавить View на таблицу в header
// и прописать ему этот класс
// после в основной контроллер добавить делегат как и с любым searchBar!
//



import UIKit

class CustomCodeSearchBar: UISearchBar {
    
    var issetImage: Bool = false
    // Констрейнты для передвижения лупы
    var searchLeadingToCenterConstaint = [NSLayoutConstraint]()
    var searchLeadingToLeftconstraint = [NSLayoutConstraint]()
    // констрейнт добавления ширны кнопки и удаления !
    var buttonWidthConstant = [NSLayoutConstraint]()
    var buttonWidthHideConstrinte = [NSLayoutConstraint]()
    var buttonSearchBar: UIButton!
    var searchImage: UIImageView!
    var buttonWidh: CGFloat?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.awakeFromNib()
        self.frame.size.height = 60
        // Добавляем лупу и кнопку отмена
        self.buttonSearchBar = UIButton()
        addButtonCancelToSearchBar()
        self.searchImage = UIImageView()
        addSearchImageToSearchBar()
        // Делаем searchBar не прозрачным меняем стиль
        self.searchBarStyle = .minimal
        self.tintColor = UIColor.systemGray2
        // действие при нажатии на кнопку
        self.buttonSearchBar.addTarget(self, action: #selector(self.tapCancelButtonSearch), for: UIControl.Event.touchUpInside)
        // Убираем родную лупу
        let image = UIImage()
        self.setImage(image, for: UISearchBar.Icon.search, state: UIControl.State.normal)
    }
    
    // Анимация при нажатии на searchBar
    func tapInSearchBar() {
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
            NSLayoutConstraint.deactivate(self.buttonWidthHideConstrinte)
            self.buttonSearchBar.frame.size.width = 0
            NSLayoutConstraint.activate(self.buttonWidthConstant)


        }
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.2,
                       options: .curveLinear) {
            self.placeholder = "Search..."
            self.setPositionAdjustment(UIOffset(horizontal: 20, vertical: 0), for: UISearchBar.Icon.search)
            NSLayoutConstraint.deactivate(self.searchLeadingToCenterConstaint)
            NSLayoutConstraint.activate(self.searchLeadingToLeftconstraint)
            self.layoutIfNeeded()
        }
    }
    
    // Анимация при нажатии кнопки
    @objc func tapCancelButtonSearch() {
        
        UIView.animate(withDuration: 0.5) {
            NSLayoutConstraint.deactivate(self.buttonWidthConstant)
            self.buttonSearchBar.frame.size.width = 0
            NSLayoutConstraint.activate(self.buttonWidthHideConstrinte)
            self.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.3,
                       options: .curveLinear) {
            self.layoutIfNeeded()
            self.placeholder = ""
            self.text = ""
            self.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: UISearchBar.Icon.search)
            NSLayoutConstraint.deactivate(self.searchLeadingToLeftconstraint)
            NSLayoutConstraint.activate(self.searchLeadingToCenterConstaint)
            
            
        }
        self.resignFirstResponder()
        
    }
}

// MARK: - расширение добавляет на SearchBar кастомные кнопку и лупу с кнострейтами

extension CustomCodeSearchBar {
    
    func addButtonCancelToSearchBar() {
        self.buttonSearchBar.backgroundColor = UIColor.red
        self.buttonSearchBar.layer.cornerRadius = 5
        self.buttonSearchBar.setTitle("Отмена", for: .normal)
        self.buttonSearchBar.sizeToFit()
        self.addSubview(buttonSearchBar)
        self.buttonSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.buttonSearchBar.topAnchor, constant: -11),
            self.bottomAnchor.constraint(equalTo: self.buttonSearchBar.bottomAnchor, constant: 11),
            self.buttonSearchBar.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: self.buttonSearchBar.trailingAnchor, constant: 8)
        ])
        self.buttonWidthConstant = [
            self.buttonSearchBar.widthAnchor.constraint(equalToConstant: self.buttonSearchBar.frame.width + 10)
        ]
        self.buttonWidthHideConstrinte = [
            self.buttonSearchBar.widthAnchor.constraint(equalToConstant: 0)
        ]
        
        NSLayoutConstraint.activate(self.buttonWidthHideConstrinte)
        
    }
    
    func addSearchImageToSearchBar() {
        if !issetImage {
            issetImage.toggle()
            self.searchImage.image = UIImage(systemName: "magnifyingglass")
            self.searchImage.tintColor = UIColor.black
            self.addSubview(self.searchImage)
            self.searchImage.translatesAutoresizingMaskIntoConstraints = false
            let centerSearchBar = (self.frame.width / 2)
            
            NSLayoutConstraint.activate([
                
                self.searchImage.widthAnchor.constraint(equalTo: self.searchImage.heightAnchor, multiplier: 1.0 / 1.0),
                self.searchImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
                self.bottomAnchor.constraint(equalTo: self.searchImage.bottomAnchor, constant: 18.5)
            ])
            
            let heightConstraint = self.searchImage.heightAnchor.constraint(equalToConstant: 23)
            heightConstraint.priority = UILayoutPriority(rawValue: 1000)
            heightConstraint.isActive = true
            self.searchLeadingToCenterConstaint = [
                self.searchImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: centerSearchBar)
            ]
            self.searchLeadingToLeftconstraint = [
                self.searchImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.minX + 15)
            ]
            
            NSLayoutConstraint.activate(self.searchLeadingToCenterConstaint)
        }
    }
}

