
import UIKit

class FeedViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let firstButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Показать первый пост"
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        config.baseBackgroundColor = .systemIndigo
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let secondButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Показать второй пост"
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        config.baseBackgroundColor = .systemIndigo
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupStackView()
        setupActions()
        setupLayout()
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
    }
    
    private func setupView() {
        title = "Лента"
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupActions() {
        firstButton.addTarget(self, action: #selector(didTapFirstButton), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(didTapSecondButton), for: .touchUpInside)
    }
    
    @objc func didTapFirstButton() {
        let post = Post(title: "Привет, это мой первый пост!")
        let postVC = PostViewController(post: post)
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func didTapSecondButton() {
        let post = Post(title: "Привет, а это мой второй пост!")
        let postVC = PostViewController(post: post)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
