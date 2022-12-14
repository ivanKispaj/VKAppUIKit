//
//  AppDelegate.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.02.2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
   // для удаления базы данных! использовал для тестирования иначе ошибки были!
   
            
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        func remove(realmURL: URL) {
                let realmURLs = [
                    realmURL,
                    realmURL.appendingPathExtension("lock"),
                    realmURL.appendingPathExtension("note"),
                    realmURL.appendingPathExtension("management"),
                    ]
                for URL in realmURLs {
                    try? FileManager.default.removeItem(at: URL)
                }
        }
 //MARK: - Использую при тестировании ( удаляю базу данных realm!!! ) временно нужный закомаентированный код!
        let url = Realm.Configuration.defaultConfiguration.fileURL!
        remove(realmURL: url)
        return true
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.

    }


}

