
import UIKit

class PostViewController: UIViewController {
    
    private let post: Post
    
    private lazy var infoBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Инфо", style: .plain, target: self, action: #selector(didTapInfoButton))
        button.width = 50
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
        setupNavigationBar()
    }
    
    private func setupView() {
        view.backgroundColor = .systemTeal
    }
    
    private func setupNavigationBar() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
        
        let infoButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc private func didTapInfoButton() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .pageSheet
        present(infoVC, animated: true)
    }
}
