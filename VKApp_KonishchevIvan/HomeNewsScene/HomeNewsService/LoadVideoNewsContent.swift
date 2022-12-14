//
//  LoadVideoNewsContent.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit

//MARK: - Получаем новости для пользователя
extension InternetConnections {
    func loadVideoContent(ovnerId id: Int, accessKey: String, videoId: Int, completion: @escaping(NewsVideoItems?) ->()) {
        
        guard let access_token = NetworkSessionData.shared.token else { return }
        
        let videos = String(id) + "_" + String(videoId) + "_" + accessKey
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "owner_id", value: String(id)),
            URLQueryItem(name: "videos", value: videos),
            URLQueryItem(name: "count", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = self.urlComponents.url else { return }
        
        self.session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(InternetError.requestError(error))
            }
            guard let data = data else {
                return
            }
            do {
                let decode = JSONDecoder()
                let result = try decode.decode(NewsVideoModel.self, from: data)
                if let items = result.response.items.first {
                    completion(items)
                } else {
                    completion(nil)
                }
            }catch {
                print(InternetError.parseError)
            }
        }.resume()
    }
}
