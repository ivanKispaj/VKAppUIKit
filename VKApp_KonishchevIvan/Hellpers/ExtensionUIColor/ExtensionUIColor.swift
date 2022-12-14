//
//  ExtensionUIColor.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 15.08.2022.
//

import Foundation
import UIKit

public enum CollorName: String {
    case alarmColor = "AlarmColor"
    case appButton = "AppButton"
    case appBlackWite = "AppBW"
    case avatarShadow = "AvatarShadow"
    case buttonTint = "ButtonTint"
    case sectionColor = "sectionColor"
}

extension UIColor {

    private static var colorCash: [CollorName : UIColor] = [:]
    
    public static func appColor(_ name: CollorName) -> UIColor {
        if let cashedColor = colorCash[name] {
            return cashedColor
        }
        self.clearColorCashIfNeeded()
         let color = UIColor(named: name.rawValue)
        colorCash[name] = color
        return color ?? systemRed
    }
    
    
    private static func clearColorCashIfNeeded() {
        let maxObjectCount = 100
        guard self.colorCash.count >= maxObjectCount else { return }
        self.colorCash = [:]
    }
}
