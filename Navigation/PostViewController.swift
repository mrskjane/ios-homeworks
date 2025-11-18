
import UIKit

class PostViewController: UIViewController {
    
    let post: Post
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post.title
        view.backgroundColor = .systemTeal
        
        let infoButton = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(showInfo))
        navigationItem.rightBarButtonItem = infoButton
    }
    @objc func showInfo() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .pageSheet
        present(infoVC, animated: true)
    }
}
