//
//  ResponseGroupJoin.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation

final class JoinGroupModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case response
        case error
    }
    var response: Bool = false
    var error: ErrorJoinGroup? = nil
    
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseInt = try container.decodeIfPresent(UInt.self, forKey: .response) ?? 0
        response = Bool(truncating: responseInt as NSNumber)
        error = try container.decodeIfPresent(ErrorJoinGroup.self, forKey: .error) ?? nil
    }
}

struct ErrorJoinGroup: Decodable {
    enum CodingKeys: String, CodingKey{
        case errorCode = "error_code"
        case errorMessage = "error_msg"
    }
    var errorCode: Int
    var errorMessage: String
}
