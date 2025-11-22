
import UIKit

class InfoViewController: UIViewController {
    
    private lazy var showAlertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Показать алерт", for: .normal)
        button.addTarget(self, action: #selector(didTapShowAlertButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        title = "Информация"
        view.backgroundColor = .systemBackground
        view.addSubview(showAlertButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func didTapShowAlertButton() {
        let alert = makeAlertController()
        present(alert, animated: true)
    }
    
    private func makeAlertController() -> UIAlertController {
        let alert = UIAlertController(title: "Заголовок", message: "Это сообщение алерта.", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            print("Нажата кнопка: Да")
        }
        
        let noAction = UIAlertAction(title: "Нет", style: .cancel) { _ in
            print("Нажата кнопка: Нет")
        }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        return alert
    }
}
