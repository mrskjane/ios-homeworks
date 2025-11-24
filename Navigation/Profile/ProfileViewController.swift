
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
        headerView.frame = view.bounds
    }
}
