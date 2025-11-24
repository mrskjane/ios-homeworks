
import UIKit

class ProfileHeaderView: UIView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50 // будет округлён до 50 при размере 100x100
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Hipster Cat"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show status", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public API
    
    func setStatusUpdateHandler(_ handler: @escaping () -> Void) {
        showStatusButton.removeTarget(nil, action: nil, for: .allEvents)
        showStatusButton.addTarget(self, action: #selector(didTapShowStatusButton), for: .touchUpInside)
        self.statusUpdateHandler = handler
    }
    
    // MARK: - Private
    
    private var statusUpdateHandler: (() -> Void)?
    
    private func setupViews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(showStatusButton)
        
        // Загружаем аватарку — можно заменить на реальное изображение позже
        avatarImageView.image = UIImage(named: "cat") // Убедитесь, что у вас есть изображение "cat" в Assets.xcassets
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Аватарка: отступ 16pt сверху и слева
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Имя: справа от аватарки, отступ 27pt, 16pt сверху от аватарки
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 27),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            // Био: под именем, отступ 34pt
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 34),
            bioLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            // Кнопка: отступ 16pt по краям, 50pt высота, 16pt под био
            showStatusButton.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Нижний отступ (чтобы кнопка не прилипала к низу)
            bottomAnchor.constraint(greaterThanOrEqualTo: showStatusButton.bottomAnchor, constant: 16)
        ])
    }
    
    @objc private func didTapShowStatusButton() {
        statusUpdateHandler?()
    }
}

