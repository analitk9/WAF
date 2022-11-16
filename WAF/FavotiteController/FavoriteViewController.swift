//
//  FavoriteViewController.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    fileprivate enum CellReuseID: String {
        case `default` = "tableViewCell"
    }
    var model = FavoriteModel()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite"
        view.backgroundColor = .white
        model.dataHandler = {
            self.tableView.reloadData()
        }
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: CellReuseID.default.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.loadModel()
    }
    
    func configureTabBar(){
        tabBarItem.image = UIImage(systemName: "photo.fill.on.rectangle.fill")
        tabBarItem.tag = 20
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [ tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
          tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
          tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach{ $0.isActive = true }
    }
    

}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(imageId: model.favorites[indexPath.section].id, image: model.images[indexPath.section])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
  
        let headerView = UIView(frame: .zero)
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseID.default.rawValue, for: indexPath) as? FavoriteTableViewCell else {fatalError()}
    
        cell.configureUI(image: model.images[indexPath.section], author: model.favorites[indexPath.section].user.name)
        
        return cell
    }
    
    
}
