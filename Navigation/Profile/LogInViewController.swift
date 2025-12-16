
import UIKit

class LogInViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let vkLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "vk_logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginTextField, separatorView, passwordTextField])
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillProportionally
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor") //цвет курсора
        textField.autocapitalizationType = .none //отключена автоматическая заглавная буква
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor") //цвет курсора
        textField.autocapitalizationType = .none //отключена автоматическая заглавная буква
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // разделитель между полями ввода
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
    
        let bluePixelImage = UIImage(named: "blue_pixel")
        button.setBackgroundImage(bluePixelImage, for: .normal)
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        // подписываемся на уведомления клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

        // отписываемся от уведомлений
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(vkLogoImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            
            // логотип VK: отступ сверху 120pt
            vkLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogoImageView.widthAnchor.constraint(equalToConstant: 100),
            vkLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // stackView под логотипом, отступ 120pt
            stackView.topAnchor.constraint(equalTo: vkLogoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100), // высота всего stackView

            // кнопка Log In: под stackView, отступ 16pt
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // функция для настройки скрытия клавиатуры
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func logInButtonTapped() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
        
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Увеличиваем нижний отступ у scrollView на высоту клавиатуры
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        // Возвращаем отступ в ноль
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}
