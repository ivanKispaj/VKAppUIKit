//
//  LoadAndSaveGroups.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 09.05.2022.
//
import UIKit
import RealmSwift
import PromiseKit

//MARK: - метод для запроса групп пользователя
extension InternetConnections {
    
    func getUrlUserGroup() -> Promise<URL> {
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(NetworkSessionData.shared.userId!)),
            URLQueryItem(name: "access_token", value: NetworkSessionData.shared.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "activity, city, description, links, site, status "),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        return Promise { resolver in
            guard let url = self.urlComponents.url else {
                resolver.reject(InternetError.urlError)
                return
            }
            
            resolver.fulfill(url)
            
        }
    }
    
    func getDataUserGroup(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            self.session.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    resolver.reject(InternetError.dataError)
                    return
                }
                resolver.fulfill(data)
            }.resume()
            
            
        }
    }
    
    func getParseData(_ data: Data) -> Promise<[ItemsGroup]> {
        return Promise { resolver in
            do {
                let decode = JSONDecoder()
                let result = try decode.decode(UserGroupModel.self, from: data)
                self.realmService.updateData(result.response.items)
                resolver.fulfill(result.response.items)
                
            }catch {
                resolver.reject(InternetError.parseError)
            }
        }
    }
    
    
}
