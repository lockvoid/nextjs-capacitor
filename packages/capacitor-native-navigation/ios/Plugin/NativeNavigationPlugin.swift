import Foundation
import Capacitor

import UIKit
import Capacitor

@objc(NativeNavigationPlugin)
public class NativeNavigationPlugin: CAPPlugin {
    public override init() {
        super.init()
    }
    
    var presentedViewControllers: [String: UIViewController] = [:] {
        didSet {
            print("self \(self)")
        }
    }
    
    @objc func setRootViewControllers(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            guard let screen = call.getArray<JSValueContainer>("screens")?.first as? JSObject else {
                call.resolve()
                return
            }
                                                          
            if let vc = self.createViewController(screen) {
                if let windowScene = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .compactMap({ $0 as? UIWindowScene })
                    .first {
                    let window = windowScene.windows.first(where: { $0.isKeyWindow })
                    (window?.rootViewController as? UINavigationController)?.setViewControllers([vc], animated: true, completion: {
                        call.resolve()
                    })
                }
            } else {
                call.resolve()
            }
        }
    }
    
    @objc func setViewControllers(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            guard let screen = call.getArray("screens")?.first as? JSObject else {
                return
            }
            if let vc = self.createViewController(screen) {
                self.bridge?.viewController?.navigationController?.setViewControllers([vc], animated: true, completion: {
                    call.resolve()
                })
            }
        }
    }
    
    @objc func pushViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let vc = self.createViewController(call.jsObjectRepresentation) {
                self.bridge?.viewController?.navigationController?.pushViewController(vc, animated: true, completion: {
                    call.resolve()
                })
            }
        }
    }
    
    @objc func presentViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let vc = self.createViewController(call.jsObjectRepresentation) {
                self.bridge?.viewController?.present(vc, animated: true, completion: {
                    call.resolve()
                })
            } else {
                call.resolve()
            }
        }
    }
    
    @objc func snapshotViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let bridgeViewController = self.bridge?.viewController as! CustomCAPBridgeViewController
            bridgeViewController.showScreenshot()
            call.resolve()
        }
    }
    
    @objc func dismissViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let bridgeViewController = self.bridge?.viewController as! CustomCAPBridgeViewController
            bridgeViewController.showScreenshot()
            bridgeViewController.dismiss(animated: true) {[weak self, weak bridgeViewController] in
                let lastBridgeViewController = bridgeViewController?.findLastPresentedBridgeViewController()
                lastBridgeViewController?.getBackWebView(webView: self?.webView, capacitorBridge: self?.bridge)
                lastBridgeViewController?.hideScreenshot()
                call.resolve()
            }
        }
    }
    
    @objc func popViewController(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let bridgeViewController = self.bridge?.viewController as! CustomCAPBridgeViewController
            bridgeViewController.showScreenshot()
            bridgeViewController.navigationController?.popViewController(animated: true, completion: {[weak self, weak bridgeViewController] in
                let lastBridgeViewController = bridgeViewController?.navigationController?.findLastBridgeViewController()
                lastBridgeViewController?.getBackWebView(webView: self?.webView, capacitorBridge: self?.bridge)
                lastBridgeViewController?.hideScreenshot()
                call.resolve()
            })
        }
    }
    
    private func createViewController(_ screen: JSObject) -> UIViewController? {
        print("url11: \(screen["url"] ?? "")")
        var viewController: UIViewController?
        if let tabs = screen["tabs"] as? [[String: Any]] {
            viewController = self.createTabBar(tabs: tabs)
        } else if let urlString = screen["url"] as? String, let url = URL(string: urlString), url.scheme == "native" {
            if let host = url.host {
                let pathComponents = [host] + url.pathComponents.dropFirst()
                viewController = self.createNativeViewController(path: pathComponents.joined(separator: "/"))
            }
        } else {
            let bridgeViewController = self.bridge?.viewController as! CustomCAPBridgeViewController
            let vc = CustomCAPBridgeViewController(webview: webView, capacitorBridge: bridge)

            viewController = vc
//            vc.viewDidAppearHandler = {[weak self, weak vc] in
//                vc?.getBackWebView(webView: self?.webView, capacitorBridge: self?.bridge)
//            }
//            vc.viewWillDisappearHandler = {[weak vc] in
//                vc?.showScreenshot()
//            }
            vc.viewDidDisappearHandler = {[weak self] in
                self?.notifyListeners("NAVIGATE_BACK", data: nil)
                bridgeViewController.getBackWebView(webView: self?.webView, capacitorBridge: self?.bridge)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    bridgeViewController.hideScreenshot()
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

extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.setViewControllers(viewControllers, animated: animated)
        CATransaction.commit()
    }
    
    @discardableResult
    func popViewController(animated: Bool, completion: @escaping () -> Void) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let poppedViewController = self.popViewController(animated: animated)
        CATransaction.commit()
        return poppedViewController
    }
    
    func findLastBridgeViewController() -> CustomCAPBridgeViewController? {
        return viewControllers.reversed().first { $0 is CustomCAPBridgeViewController } as? CustomCAPBridgeViewController
    }
}

extension UIViewController {
    func findLastPresentedBridgeViewController() -> CustomCAPBridgeViewController? {
        var currentViewController = self.presentedViewController
        var lastFoundViewController: CustomCAPBridgeViewController?

        while let viewController = currentViewController {
            if let viewControllerOfType = viewController as? CustomCAPBridgeViewController {
                lastFoundViewController = viewControllerOfType
            }
            currentViewController = viewController.presentedViewController
        }

        return lastFoundViewController
    }
}
