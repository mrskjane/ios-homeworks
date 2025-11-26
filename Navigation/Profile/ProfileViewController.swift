
import UIKit

class ProfileViewController: UIViewController {
    
    private let headerView = ProfileHeaderView()
    
    private let extraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Дополнительная кнопка", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        view.backgroundColor = .lightGray
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(headerView)
        view.addSubview(extraButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        extraButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //headerView: ширина = экран, высота = 220, привязка к Safe Area сверху
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),
            
            //Дополнительная кнопка: снизу, нулевые отступы по бокам
            extraButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            extraButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            extraButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            extraButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
