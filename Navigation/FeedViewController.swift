
import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Лента"
        view.backgroundColor = .systemBackground
        
        let button = UIButton(type: .system)
        button.setTitle("Показать пост", for: .normal)
        button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
                    button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
    }
    @objc func showPost() {
        let post = Post(title: "Привет, это мой пост!")
        let postVC = PostViewController(post: post)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
