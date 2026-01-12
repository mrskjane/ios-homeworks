
import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate {
    
    private let profileHeaderView = ProfileHeaderView()
    
    private let posts: [Post]
    
    init(posts: [Post]) {
        self.posts = posts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "cat")
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        
        return view
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        
        return button
    }()
    
    // создаем таблицу
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        
        return tableView
    }()
    
    // Начальные констрейнты

    private var avatarTopConstraint: NSLayoutConstraint!
    
    private var avatarLeadingConstraint: NSLayoutConstraint!
    
    private var avatarWidthConstraint: NSLayoutConstraint!
    
    private var avatarHeightConstraint: NSLayoutConstraint!
    
    // Конечные констрейнты (на весь экран)
    private var avatarCenterXConstraint: NSLayoutConstraint!
    
    private var avatarCenterYConstraint: NSLayoutConstraint!
    
    private var avatarFullScreenWidthConstraint: NSLayoutConstraint!
    
    private var avatarFullScreenHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        setupLayout()
        setupGesture()
        setupAnimatedViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupAnimatedViews() {
        view.addSubviews([dimmingView, closeButton])
        
        closeButton.addTarget(self, action: #selector(closeAvatarView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    private func setupLayout() {
        view.addSubviews([tableView])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateAvatar))
        avatarImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func animateAvatar() {
        self.view.addSubviews([self.avatarImageView])
        
        avatarCenterXConstraint = avatarImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        avatarCenterYConstraint = avatarImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        avatarFullScreenWidthConstraint = avatarImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        avatarFullScreenHeightConstraint = avatarImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.dimmingView.alpha = 0.75
            
            // Деактивируем старые констрейнты
            self.avatarHeightConstraint.isActive = false
            self.avatarTopConstraint.isActive = false
            self.avatarLeadingConstraint.isActive = false
            self.avatarWidthConstraint.isActive = false
            
            // Активируем новые
            self.avatarCenterXConstraint.isActive = true
            self.avatarCenterYConstraint.isActive = true
            self.avatarFullScreenWidthConstraint.isActive = true
            self.avatarFullScreenHeightConstraint.isActive = true
            
            // Убираем скругление, делаем квадрат
            self.avatarImageView.layer.cornerRadius = 0
            
            self.view.layoutIfNeeded()
            
        }) {_ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }
    
    @objc private func closeAvatarView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.closeButton.alpha = 0
        }) {_ in
            UIView.animate(withDuration: 0.5, animations: {
                self.dimmingView.alpha = 0
                self.profileHeaderView.addSubviews([self.avatarImageView])
                
                self.avatarHeightConstraint.isActive = true
                self.avatarTopConstraint.isActive = true
                self.avatarLeadingConstraint.isActive = true
                self.avatarWidthConstraint.isActive = true
                
                
                self.avatarCenterXConstraint.isActive = false
                self.avatarCenterYConstraint.isActive = false
                self.avatarFullScreenWidthConstraint.isActive = false
                self.avatarFullScreenHeightConstraint.isActive = false
                
                // Снова делаем круг
                self.avatarImageView.layer.cornerRadius = 50
                
                self.view.layoutIfNeeded()
            }) 
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    // количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    // количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return posts.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // логика лоя секции 0
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id, for: indexPath) as! PhotosTableViewCell
            cell.setup(delegate: self)
            return cell
        default:
            // логика для секции 1 (Посты)
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            cell.configure(with: post)
            return cell
        }
    }
}

extension ProfileViewController {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = profileHeaderView
            header.addSubviews([avatarImageView])
            
            avatarTopConstraint = avatarImageView.topAnchor.constraint(equalTo: header.topAnchor, constant: 16)
            avatarLeadingConstraint = avatarImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16)
            avatarWidthConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: 100)
            avatarHeightConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: 100)
            
            NSLayoutConstraint.activate([
                avatarTopConstraint,
                avatarLeadingConstraint,
                avatarWidthConstraint,
                avatarHeightConstraint
            ])
            
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 220
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return nil
       }
       
       func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           // чтобы убрать серый отступ
           return 0
       }
    
    // обработка нажатия на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // снимаем выделение (серый фон)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController: PhotoTableViewCellDelegate {
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
