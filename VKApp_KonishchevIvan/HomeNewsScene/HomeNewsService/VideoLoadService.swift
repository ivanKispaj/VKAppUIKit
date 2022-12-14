//
//  VideoLoadService.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 19.06.2022.
//

import UIKit
import AVFoundation

final class VideoLoadService {
    
    private let container: DataReloadable
    private var players = [String: AVPlayer]()
    private static let pathName: String = {
        let pathName = "video"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url,
                                                     withIntermediateDirectories: true, attributes: nil)
            
        }
        return pathName
    }()
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    func video(atIndexPath indexPath: IndexPath, byData data: NewsCellData) -> AVPlayer? {
        
        var player: AVPlayer?
        
        if let video = players[data.firstFrame.url] {
            player = video
        } else {
            getVideoPlayer(atIndexPath: indexPath, byData: data)
        }
        return player
    }
    
    private func getVideoPlayer(atIndexPath indexPath: IndexPath, byData data: NewsCellData) {
        
        let internetConnection = InternetConnectionProxy(internetConnection: InternetConnections(host: "api.vk.com", path: UrlPath.getVideo))
        internetConnection.loadVideoContent(ovnerId: data.ownerId, accessKey: data.accessKey, videoId: data.videoId) { [weak self] result in
            if result?.player != nil {
                guard let url = URL(string: result!.player) else {
                    print("Error: \(result!.player) doesn't seem to be a valid URL")
                    return
                }
                
                do {
                    let html = try String(contentsOf: url, encoding: .ascii)
                    let htmlArray = html.split(separator: ",")
                    
                    switch data.videoType {
                    case .video:
                        let url480 = htmlArray.first(where: { $0.contains("url480")})
                        let url360 = htmlArray.first(where: { $0.contains("url360")})
                        let url240 = htmlArray.first(where: { $0.contains("url240")})
                        var urlDataExt: [Substring.SubSequence]?
                        if let urlData = url480?.split(separator: ":") {
                            urlDataExt = urlData
                        } else if let urlData = url360?.split(separator: ":") {
                            urlDataExt = urlData
                        } else if let urlData = url240?.split(separator: ":") {
                            urlDataExt = urlData
                        }
                        
                        if let urlData = urlDataExt {
                            if let clearUrl = self?.getClearUrl(from: urlData) {
                                DispatchQueue.main.async {
                                    let videoURL = URL(string: clearUrl)
                                    let player = AVPlayer(url: videoURL!)
                                    player.isMuted = true
                                    player.play()
                                    self?.players[data.firstFrame.url] = player
                                    
                                }
                                DispatchQueue.main.async {
                                    self?.container.reloadRow(atIndexpath: indexPath)
                                }
                            }
                            
                        }
                    case .live:
                        let urlHls = htmlArray.first(where: { $0.contains("hls")})
                        if let hls = urlHls?.split(separator: ":") {
                            let lastHls = hls.last
                            if var clearHls = lastHls?.replacingOccurrences(of: "\\", with: "") {
                                clearHls = clearHls.replacingOccurrences(of: "\"", with: "")
                                clearHls = "https:" + clearHls
                                DispatchQueue.main.async {
                                    let videoURL = URL(string: clearHls)
                                    let player = AVPlayer(url: videoURL!)
                                    player.isMuted = true
                                    player.play()
                                    self?.players[data.firstFrame.url] = player
                                    
                                }
                                DispatchQueue.main.async {
                                    self?.container.reloadRow(atIndexpath: indexPath)
                                }
                                
                            }
                        }
                    }
                }catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    private func getClearUrl(from urlData: [Substring.SubSequence]) -> String? {
        let url = urlData.last
        if var clearUrl = url?.replacingOccurrences(of: "\\", with: "") {
            clearUrl = clearUrl.replacingOccurrences(of: "\"", with: "")
            clearUrl = "https:" + clearUrl
            return clearUrl
        }
        return nil
    }
    
}




fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension VideoLoadService {
    
    private class Table: DataReloadable {
        
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    private class Collection: DataReloadable {
        
        let collection: UICollectionView
        
        init(collection: UICollectionView) { self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
        
    }
}

