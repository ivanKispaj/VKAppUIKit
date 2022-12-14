//
//  PhotoCacheService.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 18.06.2022.
//
import UIKit


final class PhotoCacheService {
    
    private let container: DataReloadable
    private var images = [String: UIImage]()
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60 // месяц в секундах
    private static let pathName: String = {
        let pathName = "images"
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
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    func photo(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        
        guard let fileName = getFilePath(url: url), let info = try? FileManager.default.attributesOfItem(atPath: fileName), let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,  let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
        
    }
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        
        return cachesDirectory.appendingPathComponent(PhotoCacheService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data,
                                       attributes: nil)
        
    }
    
    
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        guard let uri = URL(string: url) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: uri),
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.images[url] = image
            }
            self.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }
    
}




fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoCacheService {
    
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
