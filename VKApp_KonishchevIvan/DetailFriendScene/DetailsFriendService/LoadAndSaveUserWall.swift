//
//  LoadAndSaveUserWall.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 09.05.2022.
//

import UIKit
import RealmSwift

//MARK: - Load User Wall Data!!
extension InternetConnections {
    func getUserWall(for ownerId: String) {
        guard let access_token = NetworkSessionData.shared.token else { return }
        
        self.urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: access_token),
            URLQueryItem(name: "owner_id", value: ownerId),
            URLQueryItem(name: "filter", value: "owner"),
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
                decode.userInfo = [CodingUserInfoKey(rawValue: "ownerId")! : Int(ownerId)!]
                let result = try decode.decode(UserWallModel.self, from: data)
           
                DispatchQueue.global(qos: .utility).async {
                    self.realmService.updateData(result.response)
                }
                
            }catch {
                print(InternetError.parseError)
            }
        }.resume()
    }
}
