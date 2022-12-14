//
//  NewsVideoModel.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit
import RealmSwift

 struct NewsVideoModel: Decodable {
  let response: NewsVideoModelResponse

}

struct  NewsVideoModelResponse: Decodable {
    let items: [NewsVideoItems]
}

final class NewsVideoItems: Object, Decodable {
    enum CodingKeys: String, CodingKey {
        case duration
        case player
    }
    @objc dynamic var id = 0
    @objc dynamic var duration: Int = 0
    @objc dynamic var player: String = ""
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        duration = try container.decode(Int.self, forKey: .duration)
        player = try container.decode(String.self, forKey: .player)
        id = 0
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
