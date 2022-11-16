//
//  ViewController.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import UIKit

class MainViewController: UIViewController, NotificationsProtocol {
    fileprivate enum CellReuseID: String {
        case `default` = "collectionViewCell"
    }
    private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private let itemsPerRow: CGFloat = 1
    private let model = MainModel()
    
    private let searchBar: UISearchController = {
        let searchBar = UISearchController()

        return searchBar
    }()
    
    private var searchTimer: Timer?
    
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Main"
        model.initialRequest()
        configureModelHandler()
        showSearchBar()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseID.default.rawValue)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        configureLayout()
    }
    
    private func configureLayout(){
        [collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    
  private func showSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchBar
        definesPresentationContext = true
        
    }
    
    private func configureModelHandler(){
        model.reloadDataHandler = {[weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        model.alertHandler = {[weak self] message in
            self?.showAlert(title: "Внимание", message: message)
        }
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchTimer?.invalidate()
    
        model.updateSearch(request: searchController.searchBar.text)
//        guard let query = searchController.searchBar.text, query.count != 0 else { return }
//        
//        /// debounce
//        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
//            self?.model.searchRequest(search: query)
//        })

    }
}



extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectImage = model.rawDate[indexPath.row]
        let image = model.images[selectImage.blurHash] != nil ? model.images[selectImage.blurHash]! : UIImage(blurHash: selectImage.blurHash, size: CGSize(width: 32, height: 32))!
        let detailVC = DetailViewController(imageId: selectImage.id, image: image)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.rawDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cel = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            CellReuseID.default.rawValue, for: indexPath) as? MainCollectionViewCell  else { fatalError()}
        let curImage = model.rawDate[indexPath.row]
        let image = model.images[curImage.blurHash] != nil ? model.images[curImage.blurHash] : UIImage(blurHash: curImage.blurHash, size: CGSize(width: 32, height: 32))
        cel.configure(with: image )
        return cel
    }
    
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 2*sectionInsets.left + (itemsPerRow + 1)*sectionInsets.left
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let widthPerItem = round(availableWidth / itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

