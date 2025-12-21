
import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually // делит место поровну
        stackView.spacing = 8 // расстояние между фото
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let previewImages: [UIImageView] = {
        var images = [UIImageView]()
        let imageNames = ["image_1", "image_2", "image_3", "image_4", "image_5"]
        
        for name in imageNames {
            let imageView = UIImageView()
            imageView.image = UIImage(named: name)
            imageView.backgroundColor = .black
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 6
            imageView.translatesAutoresizingMaskIntoConstraints = false
            images.append(imageView)
        }
        return images
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(photosStackView)
        
        // добавляем картинки в стэк
        for image in previewImages {
            photosStackView.addArrangedSubview(image)
        }
        
        NSLayoutConstraint.activate([
            // заголовок
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            // стрелка
            arrowImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            
            // стек фото
            photosStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            // высота картинок автоматически: ширина экрана - отступы / 4
            photosStackView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4)
        ])
    }
    
}
