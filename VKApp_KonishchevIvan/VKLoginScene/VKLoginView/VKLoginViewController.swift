//
//  VKLoginViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 12.04.2022.
//


import Foundation
import UIKit
import WebKit
import RealmSwift
import SystemConfiguration

final class DeviceId: Object {
    @objc dynamic var id = 0
    @objc dynamic var deviceId = ""
    @objc dynamic var lastSeen: Double = {
        let date = NSDate() // current date
        var unixtime = date.timeIntervalSince1970 as Double
        return unixtime.rounded()
    }()
    override class func primaryKey() -> String? {
        return "id"
    }
}

final class VKLoginViewController: UIViewController {

    let realm = RealmService()

    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: config)
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view = webView

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
        if connectedToNetwork() {
            loadAuth()
        }else {
            if let data = self.realm.readData(DeviceId.self)?.first {
                NetworkSessionData.shared.lastSeen = String(data.lastSeen)
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                   guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
                   nextVC.modalPresentationStyle = .fullScreen
                   nextVC.transitioningDelegate = nextVC
                   self.present(nextVC, animated: true)
                DispatchQueue.main.async {
                    self.present(nextVC, animated: true, completion: nil)
                }
               
            }else {
                let allert = AllertWrongUserData().getAllert(title: "Fail internet connections!", message: "First start the VKApp on this device! Please check your internet connection")
                DispatchQueue.main.async {
                    self.present(allert, animated: true)
                }
                
            }
            
        }
    
    }

}


private extension VKLoginViewController {

    func configureWebView() {
        navigationController?.navigationBar.isHidden = true
        self.webView.navigationDelegate = self
    }

    func loadAuth() {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8134649"), // ID приложения 8140649, 8142951, 8134649, 8146635
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline, friends, groups, photos, wall, status, video"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    func connectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
}

