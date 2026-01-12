import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "cat")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let currentStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Listening to music"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        
        // Внутренний отступ слева и справа — 12 pt
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        
        // Внешний вид
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.placeholder = "Введите новый статус..."
        
        return textField
    }()
    
    private let setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    private var statusText: String = "Listening to music"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .lightGray
        
        contentView.addSubviews([avatarImageView, nameLabel, currentStatusLabel, statusTextField, setStatusButton])
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        
        setStatusButton.addTarget(self, action: #selector(didTapSetStatusButton), for: .touchUpInside)
    
        NSLayoutConstraint.activate([
            //Аватарка: отступ 12pt сверху и слева
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            //Имя: справа от аватарки + 20pt, выравнивание по верху аватарки
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12),
            
            //Статус: под именем, отступ 12pt
            currentStatusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            currentStatusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            currentStatusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            //Поле ввода: под статусом, отстур 8pt, ширина как у статуса
            statusTextField.topAnchor.constraint(equalTo: currentStatusLabel.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: currentStatusLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: currentStatusLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            //Кнопка: под полем, отступ 8pt, ширина почти на весь экран
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 8),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            setStatusButton.heightAnchor.constraint(equalToConstant: 44),
            setStatusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    @objc private func didTapSetStatusButton() {
        let newStatus = statusTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !newStatus.isEmpty {
            statusText = newStatus
            currentStatusLabel.text = statusText
            statusTextField.text = "" // очистить поле после установки
            print("Статус установлен: \(statusText)")
        } else {
            print("Поле пустое — статус не изменён")
        }
    }
}
