
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
        let button = UIButton(type: .system)
        button.setTitle("Показать пост", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Показать пост", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        setupLayout()
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
    }
    
    private func setupView() {
        title = "Лента"
        view.backgroundColor = .systemBackground
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func didTapShowPostButton() {
        let post = Post(title: "Привет, это мой пост!")
        let postVC = PostViewController(post: post)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
