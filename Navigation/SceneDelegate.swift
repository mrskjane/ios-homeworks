
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        // Создаём контроллеры
        let feedVC = FeedViewController()
        feedVC.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "list.bullet"), tag: 0)
        let feedNav = UINavigationController(rootViewController: feedVC)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([feedNav, profileNav], animated: false)
        
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}

