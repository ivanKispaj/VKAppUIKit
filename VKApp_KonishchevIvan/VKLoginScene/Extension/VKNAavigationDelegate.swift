//
//  VKNAavigationDelegate.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 22.04.2022.
//


import WebKit


// MARK: - WKNavigationDelegate
extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
                  decisionHandler(.allow)
                  return
              }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        if let token = params["access_token"], let id = params["user_id"] {
            NetworkSessionData.shared.token = token
            NetworkSessionData.shared.userId = Int(id)
            print(token)
            print(id)
            if let data = self.realm.readData(DeviceId.self)?.first {
                NetworkSessionData.shared.lastSeen = String(data.lastSeen)
            }
            decisionHandler(.cancel)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
               guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
               nextVC.modalPresentationStyle = .fullScreen
               nextVC.transitioningDelegate = nextVC
               self.present(nextVC, animated: true)
        }

    }

}
