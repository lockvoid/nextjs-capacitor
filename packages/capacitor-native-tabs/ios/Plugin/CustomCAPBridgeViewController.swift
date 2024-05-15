//
//  CustomCAPViewController.swift
//  Plugin
//
//  Created by Marat Khuzhajarov on 15.05.2024.
//  Copyright © 2024 Max Lynch. All rights reserved.
//

import UIKit
import Capacitor

class CustomCAPBridgeViewController: CAPBridgeViewController {
    
    var url: URL? {
        didSet {
            loadUrlIfExist()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrlIfExist()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        if self.isMovingFromParent {
            self.webView?.configuration.userContentController.removeAllUserScripts()
            self.webView?.stopLoading()
            self.webView?.navigationDelegate = nil
            self.webView?.uiDelegate = nil
//        }
    }
    
    private func loadUrlIfExist() {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        self.webView?.load(request)
    }

}
