
import UIKit

class PostTableViewCell: UITableViewCell {
    
    var onTapLikes: (() -> Void)?
    var onTapImage: (() -> Void)?
    
    static var id = "PostCell"
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubviews([authorLabel, authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel])
        let padding: CGFloat = 16.0
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            viewsLabel.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor)
        ])
    }
    
    private func setupGestures() {
        let likesTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLikes))
        let imageTapGestire = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        likesLabel.addGestureRecognizer(likesTapGesture)
        postImageView.addGestureRecognizer(imageTapGestire)
    }
    
    @objc private func didTapLikes() {
        onTapLikes?()
        UIView.animate(withDuration: 0.1, animations: {
            self.likesLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.likesLabel.transform = .identity
            }
        }
    }
    
    @objc private func didTapImage() {
        onTapImage?()
    }
    
    func configure(with post: Post,
                   onTapLikes: @escaping (() -> Void),
                   onTapImage: (() -> Void)?) {
        authorLabel.text = post.author
        postImageView.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
        self.onTapLikes = onTapLikes
        self.onTapImage = onTapImage
    }
    
    func updateLikes(count: Int) {
        likesLabel.text = "Likes: \(count)"
    }
    
    func updateViews(count: Int) {
        viewsLabel.text = "Views: \(count)"
    }
}
