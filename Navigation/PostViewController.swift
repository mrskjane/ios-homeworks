
import UIKit

class PostViewController: UIViewController {
    
    let post: Post
    
    private lazy var infoBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(didTapInfoButton))
        return button
    }()
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
    }
    
    private func setupView() {
        title = post.title
        view.backgroundColor = .systemTeal
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = infoBarButton
    }
    
    @objc func didTapInfoButton() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .pageSheet
        present(infoVC, animated: true)
    }
}
