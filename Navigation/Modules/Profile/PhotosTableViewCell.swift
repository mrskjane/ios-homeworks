
import UIKit

protocol PhotoTableViewCellDelegate: AnyObject {
    func pushVC(_ vc: UIViewController)
}

class PhotosTableViewCell: UITableViewCell {
    
    private weak var delegate: PhotoTableViewCellDelegate?
    
    static var id = "PhotosTableViewCell"
    
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private let arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually // делит место поровну
        stackView.spacing = 8 // расстояние между фото
        
        return stackView
    }()
    
    private let previewImages: [UIImageView] = {
        var images = [UIImageView]()
        let imageNames = ["Image_1", "Image_2", "Image_3", "Image_4"]
        
        for name in imageNames {
            let imageView = UIImageView()
            imageView.image = UIImage(named: name)
            imageView.backgroundColor = .black
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 6
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
            images.append(imageView)
        }
        return images
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(delegate: PhotoTableViewCellDelegate) {
        self.delegate = delegate
    }
    
    private func setupLayout() {
        contentView.addSubviews([photosLabel, arrowButton, photosStackView])
        
        arrowButton.addTarget(self, action: #selector(arrowTapped), for: .touchUpInside)
        // добавляем картинки в стэк
        for image in previewImages {
            photosStackView.addArrangedSubview(image)
        }
        
        NSLayoutConstraint.activate([
            // заголовок
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            // стрелка
            arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowButton.heightAnchor.constraint(equalToConstant: 24),
            arrowButton.widthAnchor.constraint(equalToConstant: 24),
            
            // стек фото
            photosStackView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    @objc private func arrowTapped() {
                let photos = Photo.makeMockPhotos()
                let photoVC = PhotosViewController(photos: photos)
                self.delegate?.pushVC(photoVC)
    }
}
