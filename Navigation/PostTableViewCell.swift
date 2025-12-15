
import UIKit

class PostTableViewCell: UITableViewCell {

// автор поста
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
// изображение поста
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
// текст поста
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
// количество лайков
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

// количество просмотров
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        let padding: CGFloat = 16.0
        
        NSLayoutConstraint.activate([
            
            // authorLabel с отступама сверху, слева, справа
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            // postImageView под автором отступ 16, растягиваем на всю ширину, высота равна ширине
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: padding),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            // descriptionLabel под картинкой отспуп 16
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            // likesLabel под описанием отступ 16
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            // views выравниваем по верху с likes
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            viewsLabel.bottomAnchor.constraint(equalTo: likesLabel.bottomAnchor)
        ])
    }
        // метод для наполнения ячеек данными
        func configure(with post: Post) {
            authorLabel.text = post.author
            postImageView.image = UIImage(named: post.image)
            descriptionLabel.text = post.description
            likesLabel.text = "Likes: \(post.likes) 💖"
            viewsLabel.text = "Views: \(post.views) 👀"
        }
}
