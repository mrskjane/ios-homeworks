import UIKit

class ProfileHeaderView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setOnStatusUpdate(_ handler: @escaping (String) -> Void) {
        setStatusButton.removeTarget(nil, action: nil, for: .allEvents)
        setStatusButton.addTarget(self, action: #selector(didTapSetStatusButton), for: .touchUpInside)
        self.statusUpdateHandler = handler
    }
    
    private var statusUpdateHandler: ((String) -> Void)?
    
    private func setupViews() {
        backgroundColor = .lightGray
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(currentStatusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        
        setStatusButton.addTarget(self, action: #selector(didTapSetStatusButton), for: .touchUpInside)
    }
    
    @objc private func didTapSetStatusButton() {
        let newStatus = statusTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !newStatus.isEmpty {
            statusText = newStatus
            currentStatusLabel.text = statusText
            statusTextField.text = "" // очистить поле после установки
            statusUpdateHandler?(statusText)
            print("Статус установлен: \(statusText)")
        } else {
            print("Поле пустое — статус не изменён")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let topPadding: CGFloat = 16
        let avatarSize: CGFloat = 100
        let avatarX: CGFloat = 16
        let avatarY = topPadding
        
        avatarImageView.frame = CGRect(x: avatarX, y: avatarY, width: avatarSize, height: avatarSize)
        
        let textX = avatarX + avatarSize + 27
        let nameY = avatarY
        let nameHeight: CGFloat = 22
        
        nameLabel.frame = CGRect(x: textX, y: nameY, width: bounds.width - textX - 16, height: nameHeight)
        
        // Текущий статус (метка) — под именем, отступ 34pt
        let currentStatusY = nameY + nameHeight + 34
        let statusLabelWidth = min(nameLabel.frame.width, bounds.width - textX - 16)
        currentStatusLabel.frame = CGRect(x: textX, y: currentStatusY, width: statusLabelWidth, height: 20)
        
        // Поле ввода — под меткой, отступ 16pt, ширина как у метки
        let textFieldY = currentStatusY + currentStatusLabel.frame.height + 16
        statusTextField.frame = CGRect(
            x: textX,                          // выравнивание по тексту (не по краю экрана!)
            y: textFieldY,
            width: currentStatusLabel.frame.width, // ширина как у надписи
            height: 40
        )
        
        // Кнопка — под полем, отступ 16pt, ширина почти на весь экран
        let buttonY = textFieldY + statusTextField.frame.height + 16
        setStatusButton.frame = CGRect(
            x: 16,
            y: buttonY,
            width: bounds.width - 32, // 16pt слева + 16pt справа
            height: 50
        )
    }
}
