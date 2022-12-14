//
//  InternetConnectionProxy.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 29.08.2022.
//

import Foundation
import PromiseKit

final class InternetConnectionProxy: InternetConnectionInterface {

    
    
    let internetConnection: InternetConnections
    
 //MARK: - init
    init(internetConnection: InternetConnections) {
        self.internetConnection = internetConnection
    }
  //MARK: - methods
    func getUserNews() {
        print("Запрос новостей...")
        self.internetConnection.getUserNews()
    }
    
    func getUserNews(fromDate: String) {
        print("Запрошенны новости от \(fromDate)")
        self.internetConnection.getUserNews(fromDate: fromDate)
    }
    
    func loadVideoContent(ovnerId id: Int, accessKey: String, videoId: Int, completion: @escaping (NewsVideoItems?) -> ()) {
        print("LoadvideoContent")
        self.internetConnection.loadVideoContent(ovnerId: id, accessKey: accessKey, videoId: videoId, completion: completion)
    }
    
    func loadFriends(for userId: String, count: String = "20") {
        if count == "" {
            print("Load all friends")
        } else {
            print("Load \(count) Friends")
        }
        self.internetConnection.loadFriends(for: userId, count: count)
    }
    
    func LoadPhotoUser(for ownerId: String) {
        print("Загрузка фото пользователя \(ownerId)")
        self.internetConnection.LoadPhotoUser(for: ownerId)
    }
    
    func getUserWall(for ownerId: String) {
        print("Загрузка стены пользователя \(ownerId)")
        self.internetConnection.getUserWall(for: ownerId)
    }
    
    func getUrlUserGroup() -> Promise<URL> {
        print("Запрос url группы ")
        let result = self.internetConnection.getUrlUserGroup()
        return result
    }
    
    func joinInToGroup(for groupId: Int, completion: @escaping (Swift.Result<JoinGroupModel, Error>) -> ()) {
        print("Подписался на группу \(groupId)")
        self.internetConnection.joinInToGroup(for: groupId, completion: completion)
    }
    
    func getNewGroupList(for searchText: String, completion: @escaping (Swift.Result<NewGroupSearchModel, Error>) -> ()) {
        print("Поиск групп по : \(searchText)")
        self.internetConnection.getNewGroupList(for: searchText, completion: completion)
    }
    
    func leaveGroupService(for groupId: Int, completion: @escaping (Swift.Result<LeaveGroupModel, Error>) -> ()) {
        print("Отписался от группы:  \(groupId)")
        self.internetConnection.leaveGroupService(for: groupId, completion: completion)
    }
    
    func getDataUserGroup(_ url: URL) -> Promise<Data> {
        print("Получение данных группы по URL")
        let result = self.internetConnection.getDataUserGroup(url)
        return result
    }
    func getParseData(_ data: Data) -> Promise<[ItemsGroup]> {
        print("ParseData usergroup")
        let result = internetConnection.getParseData(data)
        return result
    }
}

