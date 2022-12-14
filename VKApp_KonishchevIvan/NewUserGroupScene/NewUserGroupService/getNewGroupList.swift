//
//  NewGroupService.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 23.04.2022.
//

import UIKit

extension InternetConnections {
    func getNewGroupList(for searchText: String, completion: @escaping(Result<NewGroupSearchModel,Error>) -> ()) {
        
        guard let access_token = NetworkSessionData.shared.token else { return }
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "sort", value: "6"),
            URLQueryItem(name: "type", value: "group, page, event"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "1000")
        ]
        
        guard let url = self.urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard error == nil else { return }
            guard let data = data else { return }
            let decode = JSONDecoder()
            
            do {
                let result = try decode.decode(NewGroupSearchModel.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


