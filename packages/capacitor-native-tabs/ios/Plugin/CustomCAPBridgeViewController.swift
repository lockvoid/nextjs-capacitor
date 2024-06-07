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
    
    public override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        super.viewDidAppear(animated)
    }
    
    public func loadUrlIfExist() {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        self.webView?.load(request)
    }

}
