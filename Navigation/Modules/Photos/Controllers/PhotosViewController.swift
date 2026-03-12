
import UIKit

final class PhotosViewController: UIViewController {
    
    private let photos: [String]
    
    private let dimmingView: UIView = {
          let view = UIView()
          view.backgroundColor = .black
          view.alpha = 0
          return view
      }()
      
      private let animatingImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.contentMode = .scaleAspectFill
          imageView.clipsToBounds = true
          return imageView
      }()
      
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    
    private var initialConstraints: [NSLayoutConstraint] = []
    private var finalConstraints: [NSLayoutConstraint] = []
    
    init(photos: [String]) {
        self.photos = photos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupView() {
         title = "Photo Gallery"
         view.backgroundColor = .white
     }
    
    private func setupLayout() {
        view.addSubviews([collectionView, dimmingView])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func showFullScreenImage(image: UIImage, initialRect: CGRect) {
        animatingImageView.image = image
        view.addSubviews([animatingImageView])
        
        NSLayoutConstraint.deactivate(initialConstraints)
        initialConstraints = [
            animatingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: initialRect.origin.y),
            animatingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: initialRect.origin.x),
            animatingImageView.widthAnchor.constraint(equalToConstant: initialRect.width),
            animatingImageView.heightAnchor.constraint(equalToConstant: initialRect.height)
        ]
        NSLayoutConstraint.activate(initialConstraints)
        view.layoutIfNeeded()

        if finalConstraints.isEmpty {
            finalConstraints = [
                animatingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                animatingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                animatingImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animatingImageView.heightAnchor.constraint(equalTo: view.widthAnchor)
            ]
        }

        NSLayoutConstraint.deactivate(initialConstraints)
        NSLayoutConstraint.activate(finalConstraints)
        view.setNeedsLayout()

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.dimmingView.alpha = 0.8
            self.view.layoutIfNeeded()
        } completion: { _ in
                let closeItem = UIBarButtonItem(
                    image: UIImage(systemName: "xmark"),
                    style: .plain,
                    target: self,
                    action: #selector(self.closeFullScreenImage)
                )
                self.navigationItem.rightBarButtonItem = closeItem
                self.navigationController?.navigationBar.layoutIfNeeded()
        }
    }
    
    @objc private func closeFullScreenImage() {
        navigationItem.rightBarButtonItem = nil
        NSLayoutConstraint.deactivate(self.finalConstraints)
        NSLayoutConstraint.activate(self.initialConstraints)
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.dimmingView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.animatingImageView.removeFromSuperview()
            self.animatingImageView.image = nil
            NSLayoutConstraint.deactivate(self.initialConstraints)
            self.initialConstraints.removeAll()
            self.finalConstraints.removeAll()
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotosCollectionViewCell

        let imageName = photos[indexPath.item]
        cell.configure(with: imageName)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell,
              let image = cell.photoImageView.image else { return }
        let cellRect = cell.convert(cell.bounds, to: view)
        showFullScreenImage(image: image, initialRect: cellRect)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let spacing: CGFloat = 8
            let countOfItems: CGFloat = 3
            let totalSpacing = (spacing * (countOfItems + 1))
            let availableWidth = collectionView.frame.width - totalSpacing
            let itemWidth = availableWidth / countOfItems
            return CGSize(width: itemWidth, height: itemWidth)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
}

