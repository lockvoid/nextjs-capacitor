import Foundation
import Capacitor

import UIKit
import Capacitor

@objc(NativeTabsPlugin)
public class NativeTabsPlugin: CAPPlugin {
    public override init() {
        super.init()
    }
    
    var presentedViewControllers: [String: UIViewController] = [:] {
        didSet {
            print("self \(self)")
        }
    }
    
    @objc func pushViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let vc = self.createViewController(call) {
                self.bridge?.viewController?.navigationController?.pushViewController(vc, animated: true)
            }
            call.resolve()
        }
    }
    
    @objc func presentViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let vc = self.createViewController(call) {
                self.bridge?.viewController?.present(vc, animated: true, completion: {
                    call.resolve()
                })
            } else {
                call.resolve()
            }
        }
    }
    
    @objc func prepareViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let bridgeViewController = self.bridge?.viewController as! CustomCAPBridgeViewController
            bridgeViewController.showScreenshot()
            call.resolve()
        }
    }
    
    private func createViewController(_ call: CAPPluginCall) -> UIViewController? {
        print("url11: \(call.getString("url") ?? "")")
        var viewController: UIViewController?
        if let tabs = call.getArray("tabs", [String: Any].self) {
            viewController = self.createTabBar(tabs: tabs)
        } else if let urlString = call.getString("url"), let url = URL(string: urlString) {
            if url.scheme == "native" {
                if let host = url.host {
                    let pathComponents = [host] + url.pathComponents.dropFirst()
                    viewController = self.createNativeViewController(path: pathComponents.joined(separator: "/"))
                }
            } else {
                let bridgeViewController = self.bridge?.viewController as! CustomCAPBridgeViewController
                let vc = CustomCAPBridgeViewController(webview: webView, capacitorBridge: bridge)

                viewController = vc
                vc.viewDidAppearHandler = {[weak self, weak vc] in
                    vc?.getBackWebView(webView: self?.webView, capacitorBridge: self?.bridge)
                }
                vc.viewWillDisappearHandler = {[weak vc] in
                    vc?.showScreenshot()
                }
                vc.viewDidDisappearHandler = {[weak self] in
                    self?.notifyListeners("NAVIGATE_BACK", data: nil)
                    bridgeViewController.getBackWebView(webView: self?.webView, capacitorBridge: self?.bridge)
                }
            }
        }
        return viewController
    }
    
    private func createTabBar(tabs: [[String: Any]]) -> UIViewController {
        let tabBar = UITabBarController()
        var viewControllers = [UIViewController]()

        for tab in tabs {
            if let vc = self.viewController(for: tab) {
                viewControllers.append(vc)
            }
        }

        tabBar.viewControllers = viewControllers
        return tabBar
    }
    
    private func viewController(for tabInfo: [String: Any]) -> UIViewController? {
        guard let urlString = tabInfo["url"] as? String else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        let vc = CustomCAPBridgeViewController()
        vc.url = url
        let navVc = UINavigationController(rootViewController: vc)
        navVc.tabBarItem = UITabBarItem(title: tabInfo["title"] as? String, image: nil, selectedImage: nil)
        return navVc
    }
    
    private func createNativeViewController(path: String) -> UIViewController? {
        print("path: \(path)")
        switch path {
        case "redCustomVc":
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            
            let button = UIButton(frame: CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 100, height: 20)))
            button.backgroundColor = .black
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            vc.view.addSubview(button)
            return vc
        default:
            return nil
        }
    }
    
    @objc private func buttonAction() {
    }
}
