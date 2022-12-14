//
//  unixTimeConvertionDouble.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation


extension Double {
    func  unixTimeConvertion() -> String {
        let time = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale?
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let dateAsString = dateFormatter.string(from: time as Date)
        return dateAsString
    }
}
