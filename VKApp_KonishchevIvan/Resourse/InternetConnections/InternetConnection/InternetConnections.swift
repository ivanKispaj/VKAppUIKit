//
//  InternetConnections.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 17.04.2022.
//

import UIKit
import RealmSwift
import PromiseKit


//MARK: - Internet connectionInterface

protocol InternetConnectionInterface {
    func getUserNews()
    func getUserNews(fromDate: String)
    func loadVideoContent(ovnerId id: Int, accessKey: String, videoId: Int, completion: @escaping(NewsVideoItems?) ->())
    func loadFriends(for userId: String, count: String )
    func LoadPhotoUser(for ownerId: String)
    func getUserWall(for ownerId: String)
    func getUrlUserGroup() -> Promise<URL>
    func getDataUserGroup(_ url: URL) -> Promise<Data>
    func getParseData(_ data: Data) -> Promise<[ItemsGroup]>
    func joinInToGroup(for groupId: Int, completion: @escaping(Swift.Result<JoinGroupModel, Error>) -> ())
    func getNewGroupList(for searchText: String, completion: @escaping(Swift.Result<NewGroupSearchModel,Error>) -> ())
    func leaveGroupService(for groupId: Int, completion: @escaping(Swift.Result<LeaveGroupModel,Error>) -> ())
}
//MARK: - Internet Error
enum InternetError: Error {
    case requestError(Error)
    case parseError
    case urlError
    case dataError
    
}

//MARK: - url Path
enum UrlPath: String {
    case getNews = "/method/newsfeed.get"
    case getVideo = "/method/video.get"
    case getFriends = "/method/friends.get"
    case getAllPhoto = "/method/photos.getAll"
    case getWall = "/method/wall.get"
    case getGroups = "/method/groups.get"
    case leaveGroup = "/method/groups.leave"
    case searchGroup = "/method/groups.search"
    case joinGroups = "/method/groups.join"
}


// MARK: - Класс для доступа в интернет по умолчанию протокол(схема) hhtps, host и path надо передавать при создании соединения
final class InternetConnections: InternetConnectionInterface {
    
    let realmService = RealmService()
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    var urlComponents: URLComponents!
    //MARK: - init
    init (scheme: String = "https", host: String, path: UrlPath) {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = scheme
        self.urlComponents.host = host
        self.urlComponents.path = path.rawValue
    }
}





