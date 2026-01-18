
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
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        return tableView
    }()
    
    private var initialConstraints: [NSLayoutConstraint] = []
    private var finalConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        setupLayout()
        setupAnimatedViews()
        setupGesture()
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
        view.addSubviews([avatarImageView])
        
        NSLayoutConstraint.deactivate(initialConstraints)
        initialConstraints = [
            avatarImageView.topAnchor.constraint(equalTo: profileHeaderView.contentView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: profileHeaderView.contentView.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(initialConstraints)
        view.layoutIfNeeded()
        NSLayoutConstraint.deactivate(initialConstraints)
        if finalConstraints.isEmpty {
            finalConstraints = [
                avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                avatarImageView.heightAnchor.constraint(equalTo: view.widthAnchor)
            ]
        }
        NSLayoutConstraint.activate(finalConstraints)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.dimmingView.alpha = 0.75
            self.avatarImageView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }
    
    @objc private func closeAvatarView() {
        
        UIView.animate(withDuration: 0, animations: {
            self.closeButton.alpha = 0
        }) { _ in
            NSLayoutConstraint.deactivate(self.finalConstraints)
            NSLayoutConstraint.activate(self.initialConstraints)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.dimmingView.alpha = 0
                self.avatarImageView.layer.cornerRadius = 50
                self.view.layoutIfNeeded()
            }) { _ in
                if self.avatarImageView.superview == self.view {
                    self.profileHeaderView.contentView.addSubview(self.avatarImageView)
                    NSLayoutConstraint.activate(self.initialConstraints)
                }
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return posts.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id, for: indexPath) as! PhotosTableViewCell
            cell.setup(delegate: self)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            cell.configure(with: post)
            return cell
        }
    }
}

extension ProfileViewController {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 0 {
                let header = profileHeaderView
                if avatarImageView.superview != self.view {
                    header.contentView.addSubviews([avatarImageView])
                    NSLayoutConstraint.activate([
                        avatarImageView.topAnchor.constraint(equalTo: header.contentView.topAnchor, constant: 16),
                        avatarImageView.leadingAnchor.constraint(equalTo: header.contentView.leadingAnchor, constant: 16),
                        avatarImageView.widthAnchor.constraint(equalToConstant: 100),
                        avatarImageView.heightAnchor.constraint(equalToConstant: 100)
                    ])
                }
                return header
            }
            return nil
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
           return 0
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController: PhotoTableViewCellDelegate {
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
