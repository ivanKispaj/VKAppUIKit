//
//  RealmService.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 10.05.2022.
//

import RealmSwift
import Realm

final class RealmService {
  
// удаление объекта из базы
    func deliteData<T: Object> (_ object: T, cascading: Bool) {
        do {
            let realm = try Realm()
            try! realm.write{
                realm.delete(object, cascading: true)
            }
            
        }catch {
           print(error)
        }
    }
// Обновление данных в базе
    func updateData<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        }catch {
            print(error)
        }
    }

// Обновление данных в базе массивом
    func updateData<T: Object>(_ object: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        }catch {
            print(error)
        }
    }
 
// Запись данных в базу
    func saveData<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
           
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        }catch {
            print(error)
        }
    }
    
    func printConfiguration() {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL!)
        }catch {
            print("error print configuration")
        }
    }
 // чтение данных из базы
    func readData<T: Object>(_ object: T.Type) -> Results<T>? {
        do {
            let realm = try Realm()
            return realm.objects(object)
        }catch {
            print("Error readData from RealmBase")
        }
        return nil
    }
    
}

//MARK: - Extension Realm Cascade Delite Objects
protocol CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool)
}

extension Realm: CascadeDeleting {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object {
        for obj in objects {
            delete(obj, cascading: cascading)
        }
    }
    
    func delete<Entity: Object>(_ entity: Entity, cascading: Bool) {
        if cascading {
            cascadeDelete(entity)
        } else {
            delete(entity)
        }
    }
}


//MARK: - каскадное удаление объектов в базе данных
private extension Realm {
    private func cascadeDelete(_ entity: RLMObjectBase) {
        guard let entity = entity as? Object else { return }
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(entity)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object,
                !element.isInvalidated else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
        }
    }
    
    private func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        element.objectSchema.properties.forEach {
            guard let value = element.value(forKey: $0.name) else { return }
            if let entity = value as? RLMObjectBase {
                toBeDeleted.insert(entity)
            } else if let list = value as? RLMSwiftCollectionBase {
                for index in 0..<list._rlmCollection.count {
                    if let entity = list._rlmCollection.object(at: index) as? RLMObjectBase {
                        toBeDeleted.insert(entity)
                    }
                }
            }
        }
        
        delete(element)
    }
}
