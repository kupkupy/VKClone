//
//  AuthViewController.swift
//  RealProject
//
//  Created by Tanya on 25.04.2022.
//

import UIKit
import WebKit

final class AuthVC: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: UIScreen.main.bounds)
        webView.navigationDelegate = self
        //webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // узнать директорию проекта
        print(NSHomeDirectory())
        
        // если токен "живой", то авторизация пропускается
        if Session.shared.tokenIsValid {
            showMainTabScreen()
            return
        }
        
        oauthRequestToGetToken()
    }
    
    //MARK: - Private methods
    private func setupViews() {
        view.addSubview(webView)
    }
    
    func showMainTabScreen() {
        let mainTBC = MainTabBarVC()
        navigationController?.pushViewController(mainTBC, animated: true)
        
        //Убираем навбар в TabBarVC чтобы не отобразилось 2 навбара при добавлении навбара в TabBarVC
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Requests
    private func oauthRequestToGetToken() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "271382"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}

//MARK: - WKNavigationDelegate
extension AuthVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html" else {
            decisionHandler(.allow)
            return
        }
        print(url)
        
        //Получила url:
        /*
         https://oauth.vk.com/blank.html#access_token=004d3a191dd10ce7f22204800de16975138afa7c7cc33071128416f58fbf56c64c19b1236a37675254b91&expires_in=86400&user_id=545482565
         */
        
        //Fragments:
       // #access_token=004d3a191dd10ce7f22204800de16975138afa7c7cc33071128416f58fbf56c64c19b1236a37675254b91&expires_in=86400&user_id=545482565
        
        //params:
        // [access_token, 004d3a191dd10ce7f22204800de16975138afa7c7cc33071128416f58fbf56c64c19b1236a37675254b91, expires_in, 86400, user_id, 545482565]
        
        let params = url.fragment?
            .components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String: String](), { result, item in
                var dict = result
                let key = item[0]
                let value = item[1]
                dict[key] = value
                return dict
            })
        
        guard let token = params?["access_token"], let userID = params?["user_id"] else { return }
        
        let intUserID = Int(userID)
        
        Session.shared.token = token
        Session.shared.userID = intUserID ?? 0
        
        showMainTabScreen()
        
        decisionHandler(.cancel)
    }
}
