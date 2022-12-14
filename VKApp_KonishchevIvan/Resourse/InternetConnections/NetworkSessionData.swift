//
//  NetvorkSessionData.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.04.2022.
//

import Foundation

final class NetworkSessionData {
    
    static var shared = NetworkSessionData()
    var token: String?
    var userId: Int?
    var lastSeen: String?
    var testUser: Int = 72287677 // удалить после завершения тестов!
    
    private init(){}
}
