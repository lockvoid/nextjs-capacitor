//
//  CustomCAPViewController.swift
//  Plugin
//
//  Created by Marat Khuzhajarov on 15.05.2024.
//  Copyright © 2024 Max Lynch. All rights reserved.
//

import UIKit
import Capacitor

public class CustomCAPBridgeViewController: CAPBridgeViewController {
    
    public var url: URL? {
        didSet {
            loadUrlIfExist()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        loadUrlIfExist()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        super.viewDidDisappear(animated)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
    }
    
    public func loadUrlIfExist() {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        self.webView?.load(request)
    }

}


//class CustomCAPBridgeViewController2: CAPBridgeViewController {
//    
//    var url: URL? {
//        didSet {
//            loadUrlIfExist()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let webView = webView {
//            view = UIView()
//            view.backgroundColor = .white
//            
//            view.addSubview(webView)
//            
//            webView.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                webView.topAnchor.constraint(equalTo: view.topAnchor),
//                webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//            ])
//        }
//        
//        loadUrlIfExist()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        self.webView?.configuration.userContentController.removeAllUserScripts()
//        self.webView?.stopLoading()
//        self.webView?.navigationDelegate = nil
//        self.webView?.uiDelegate = nil
//    }
//    
//    private func loadUrlIfExist() {
//        guard let url = url else { return }
//        let request = URLRequest(url: url)
//        self.webView?.load(request)
//    }
//
//}
