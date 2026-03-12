
import UIKit

final class FeedViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstButton, secondButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var firstButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Показать первый пост"
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        config.baseBackgroundColor = .systemIndigo
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(didTapFirstButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Показать второй пост"
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        config.baseBackgroundColor = .systemIndigo
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(didTapSecondButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        title = "Лента"
        view.addSubviews([stackView])
        view.backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func didTapFirstButton() {
        let post = Post(author: "Jane", description: "Это мой первый пост!", detailedText: "Это мой первый пост!", image: "post_image_1", likes: 30, views: 30)
        let postVC = PostViewController(post: post)
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func didTapSecondButton() {
        let post = Post(author: "Jane", description: "Это мой второй пост!", detailedText: "Это мой второй пост!", image: "post_image_1", likes: 30, views: 30)
        let postVC = PostViewController(post: post)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
