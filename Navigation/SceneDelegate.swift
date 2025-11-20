
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = makeRootViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func makeRootViewController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([makeFeedNavigationController(), makeProfileNavigationController()], animated: false)
        return tabBarController
    }
    
    private func makeFeedNavigationController() -> UINavigationController {
        let feedVC = FeedViewController()
        feedVC.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "list.bullet"), tag: 0)
        return UINavigationController(rootViewController: feedVC)
    }
    
    private func makeProfileNavigationController() -> UINavigationController {
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        return UINavigationController(rootViewController: profileVC)
    }
}

