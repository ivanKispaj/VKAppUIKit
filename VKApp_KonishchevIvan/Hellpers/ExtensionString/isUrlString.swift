//
//  chekingValidityUrl.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.04.2022.
//
// расширение проверяет является ли строка url адресом

import UIKit
//MARK: - проверка соответствует ли строка URL

extension String {
    func isUrlString() -> Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}

extension String {
    
    func loadImageFromUrlString() -> UIImage? {
        guard self != "" else { return nil}
        let url = URL(string: self)!
            let content = try? Data(contentsOf: url)
                if let imageData = content {
                    return  UIImage(data: imageData)
                } else {
                    return  UIImage(named: "noFoto")
                }


    }
}
