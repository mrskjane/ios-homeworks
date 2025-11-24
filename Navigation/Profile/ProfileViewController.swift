
import UIKit

class ProfileViewController: UIViewController {
    
    private let headerView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        view.backgroundColor = .lightGray
        view.addSubview(headerView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let insets = view.safeAreaInsets
        headerView.frame = CGRect(
            x: 0,
            y: insets.top,
            width: view.bounds.width,
            height: view.bounds.height - insets.top - insets.bottom
        )
    }
}
