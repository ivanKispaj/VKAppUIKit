//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.05.2022.
//

import Foundation

extension InternetConnections {
    func joinInToGroup(for groupId: Int, completion: @escaping(Result<JoinGroupModel,Error>) -> ()) {
        
        guard let access_token = NetworkSessionData.shared.token else { return }
        
        let id = String(groupId)
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "group_id", value: id),
            URLQueryItem(name: "not_sure", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = self.urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            let decode = JSONDecoder()
            
            do {
                let result = try decode.decode(JoinGroupModel.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
