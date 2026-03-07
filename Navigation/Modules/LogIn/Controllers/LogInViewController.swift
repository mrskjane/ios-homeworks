
import UIKit

final class LogInViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let vkLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "vk_logo"))
        imageView.contentMode = .scaleAspectFit
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
        return stack
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.textColor = .black
        passwordTextField.tintColor = UIColor(named: "AccentColor")
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        return passwordTextField
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
    }()
    
    private lazy var logInButton: UIButton = {
        let loginTextField = UIButton(type: .system)
        loginTextField.setTitle("Log in", for: .normal)
        loginTextField.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        loginTextField.setTitleColor(.white, for: .normal)
        
        let bluePixelImage = UIImage(named: "blue_pixel")
        loginTextField.setBackgroundImage(bluePixelImage, for: .normal)
        loginTextField.layer.cornerRadius = 10
        loginTextField.clipsToBounds = true
        loginTextField.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return loginTextField
    }()
    
    private let passwordHintLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.isHidden = true
        
        return label
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupLayout() {
        view.addSubviews([scrollView])
        scrollView.addSubviews([contentView])
        contentView.addSubviews([vkLogoImageView, stackView, passwordHintLabel, logInButton])
        
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
            
            vkLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogoImageView.widthAnchor.constraint(equalToConstant: 100),
            vkLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: vkLogoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            passwordHintLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            passwordHintLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordHintLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            logInButton.topAnchor.constraint(equalTo: passwordHintLabel.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func resetBorders() {
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        separatorView.backgroundColor = .lightGray
        resetTextFieldBorder(loginTextField)
        resetTextFieldBorder(passwordTextField)
    }
    
    private func highlightTextField(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemRed.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
    }
    
    private func resetTextFieldBorder(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func highlightStackBorder() {
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.systemRed.cgColor
        separatorView.backgroundColor = .systemRed
    }
    
    private func showHint(_ text: String) {
        passwordHintLabel.text = text
        passwordHintLabel.isHidden = false
    }
    
    @objc private func logInButtonTapped() {
        resetBorders()
        passwordHintLabel.text = nil
        passwordHintLabel.isHidden = true
        
        do {
            try AuthService.shared.authorize(
                login: loginTextField.text,
                pass: passwordTextField.text
            )
            resetBorders()
            passwordHintLabel.text = nil
            passwordHintLabel.isHidden = true
            let profileVC = ProfileViewController(posts: Post.makeMockPosts())
            navigationController?.pushViewController(profileVC, animated: true)
        } catch AuthError.bothEmpty {
            loginTextField.shake()
            passwordTextField.shake()
            highlightStackBorder()
            showHint("Пустой логин и пароль")
        } catch AuthError.emptyLogin {
            loginTextField.shake()
            highlightTextField(loginTextField)
            showHint("Пустой логин")
        } catch AuthError.emptyPassword {
            passwordTextField.shake()
            highlightTextField(passwordTextField)
            showHint("Пустой пароль")
        } catch AuthError.invalidEmail {
            loginTextField.shake()
            showAlert(message: "Некорректный формат e-mail")
        } catch AuthError.shortPassword {
            passwordTextField.shake()
            highlightTextField(passwordTextField)
            showHint("Пароль должен содержать минимум 6 символов")
        } catch AuthError.wrongCredentials {
            showAlert(message: "Неверный логин или пароль")
        } catch {
            showAlert(message: "Что-то пошло не так")
        }
    }
    
    @objc private func textFieldsChanged() {
        resetBorders()
        if !passwordHintLabel.isHidden {
            passwordHintLabel.text = nil
            passwordHintLabel.isHidden = true
        }
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}
