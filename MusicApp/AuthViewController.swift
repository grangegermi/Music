//
//  AuthViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    var webView:WKWebView = {
       let preferens = WKWebpagePreferences()
        preferens.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferens
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.backgroundColor = .systemGray
        webView.navigationDelegate = self
        createConstraints()
        guard let url = AuthManager.shared.isSignedURL else {return}
        
        webView.load(URLRequest(url: url))
//        AuthManager.shared.getTokens()
       
        
    }

    func createConstraints() {
        webView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        guard let url = webView.url else {return}
        
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value
        else {return}
        
        print("\(code)")
        AuthManager.shared.getTokens(code:code){ [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
        }

    }
 }
}
