//
//  AllertWrongUserData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 15.02.2022.
//

import UIKit

class AllertWrongUserData {
 
//MARK: - создает аллерт сообщение
    // title -> название аллерта
    // message -> сообщение в аллерте
     func getAllert( title: String, message: String ) -> UIAlertController {
        let allert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let allertAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        allert.addAction(allertAction)
       return allert
    }
}
