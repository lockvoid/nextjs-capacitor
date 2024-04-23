import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(NativeTabsPlugin)
public class NativeTabsPlugin: CAPPlugin {
    @objc func push(_ call: CAPPluginCall) {
        guard let urlString = call.getString("url"), let url = URL(string: urlString) else {
            call.reject("Must provide a URL")
            return
        }
        
        
        print(urlString)
        
        DispatchQueue.main.async {
            // Create a new CAPBridgeViewController instance
            let newWebView = CAPBridgeViewController()

            newWebView.setServerBasePath(path: url.path)

            // Assuming you have a UINavigationController
            if let navigationController = self.bridge?.viewController?.navigationController {
                navigationController.pushViewController(newWebView, animated: true)

                call.resolve()
            } else {
                call.reject("NavigationController not found")
            }
        }
    }

    @objc func createTabs(_ call: CAPPluginCall) {
        guard let urlString = call.getString("url"), let url = URL(string: urlString) else {
            call.reject("Must provide a URL")
            return
        }
        
        DispatchQueue.main.async {
            // Create a new CAPBridgeViewController instance
            let newWebView = CAPBridgeViewController()

            newWebView.setServerBasePath(path: url.path)

            // Assuming you have a UINavigationController
            if let navigationController = self.bridge?.viewController?.navigationController {
                navigationController.pushViewController(newWebView, animated: true)

                call.resolve()
            } else {
                call.reject("NavigationController not found")
            }
        }
        
        return;
        
        DispatchQueue.main.async {
            guard let bridgeViewController = self.bridge?.viewController as? CAPBridgeViewController else {
                call.reject("Capacitor Bridge View Controller not found.")
                return
            }

            // Example: Creating a simple tab bar controller with two tabs
            let tabBarController = UITabBarController()
            
            // Create UIViewController for each tab, setup is simplified
            let firstTab = UIViewController()
            firstTab.view.backgroundColor = .red
            firstTab.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            
            let secondTab = UIViewController()
            secondTab.view.backgroundColor = .blue
            secondTab.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
            
            tabBarController.viewControllers = [firstTab, secondTab]
            
            // Add action to switch tabs
            tabBarController.selectedIndex = 0 // Default to first tab
            
            // Present the tab bar controller
            bridgeViewController.present(tabBarController, animated: true, completion: nil)

            // Example of how you might handle a tab switch, this needs to be customized
            // to trigger when actual tab switches occur in your tab bar controller
            let selectedIndex = tabBarController.selectedIndex
            self.bridge?.triggerJSEvent(eventName: "onTabSelected", target: "window", data: "{\"tabIndex\": \(selectedIndex)}")
        }

        call.resolve()
    }
}
