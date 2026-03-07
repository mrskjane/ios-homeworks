
import UIKit

final class ProfileViewController: UIViewController, UITableViewDelegate {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateAvatar))
        headerView.avatarImageView.addGestureRecognizer(tapGesture)
        return headerView
    }()
    
    private var posts: [Post]
    
    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private lazy var closeButton: UIButton = {
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
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var initialConstraints: [NSLayoutConstraint] = []
    private var finalConstraints: [NSLayoutConstraint] = []
    
    init(posts: [Post]) {
        self.posts = posts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupLayout() {
        view.backgroundColor = .systemGray6
        view.addSubviews([tableView, dimmingView, closeButton])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        closeButton.addTarget(self, action: #selector(closeAvatarView), for: .touchUpInside)
    }
    
    @objc private func animateAvatar() {
        let avatar = profileHeaderView.avatarImageView
        view.addSubviews([avatar])
        NSLayoutConstraint.activate(profileHeaderView.avatarConstraints)
        view.layoutIfNeeded()
        if finalConstraints.isEmpty {
            finalConstraints = [
                avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                avatar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                avatar.widthAnchor.constraint(equalTo: view.widthAnchor),
                avatar.heightAnchor.constraint(equalTo: view.widthAnchor)
            ]
        }
        NSLayoutConstraint.deactivate(profileHeaderView.avatarConstraints)
        NSLayoutConstraint.activate(finalConstraints)
        view.setNeedsLayout()
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.dimmingView.alpha = 0.75
            avatar.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.3) { self.closeButton.alpha = 1 }
        }
    }
    
    @objc private func closeAvatarView() {
        let avatar = profileHeaderView.avatarImageView
        UIView.animate(withDuration: 0, animations: {
            self.closeButton.alpha = 0
        }) { _ in
            NSLayoutConstraint.deactivate(self.finalConstraints)
            NSLayoutConstraint.activate(self.profileHeaderView.avatarConstraints)
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.dimmingView.alpha = 0
                avatar.layer.cornerRadius = 50
                self.view.layoutIfNeeded()
            }) { _ in
                if avatar.superview == self.view {
                    self.profileHeaderView.contentView.addSubview(avatar)
                    NSLayoutConstraint.activate(self.initialConstraints)
                    self.profileHeaderView.contentView.setNeedsLayout()
                    self.profileHeaderView.contentView.layoutIfNeeded()
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
            let postIndex = indexPath.row
            cell.configure(with: post)
            cell.onTapLikes = { [weak self, weak cell] in
                guard let self = self, let cell = cell else { return }
                self.posts[postIndex].likes += 1
                cell.updateLikes(count: self.posts[postIndex].likes)
            }
            cell.onTapImage = { [weak self, weak cell] in
                guard let self = self, let cell = cell else { return }
                self.posts[postIndex].views += 1
                let updatedPost = self.posts[postIndex]
                cell.updateViews(count: self.posts[postIndex].views)
                let detailedVC = DetailedPostViewController(post: updatedPost)
                self.navigationController?.pushViewController(detailedVC, animated: true)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.section == 1 ? .delete : .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.section == 1, editingStyle == .delete else { return }
        posts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension ProfileViewController {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return profileHeaderView
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
        view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension ProfileViewController: PhotoTableViewCellDelegate {
    func didTapPhotosArrow() {
        let photos = Photo.makeMockPhotos()
        let photoVC = PhotosViewController(photos: photos)
        navigationController?.pushViewController(photoVC, animated: true)
    }
}
