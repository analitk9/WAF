//
//  FavoriteTableViewCell.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    var height: CGFloat = 100
    
    var favoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        return imageView
    }()
    var imageAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews([favoriteImage, imageAuthor])
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
   private  func configureLayout(){
      
       
        [ favoriteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
          favoriteImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
          favoriteImage.heightAnchor.constraint(equalToConstant: height),
          favoriteImage.widthAnchor.constraint(equalToConstant: height),
          imageAuthor.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 25.0),
          imageAuthor.topAnchor.constraint(equalTo: favoriteImage.topAnchor),
          imageAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
          imageAuthor.bottomAnchor.constraint(equalTo: favoriteImage.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    
    func configureUI(image: UIImage, author: String){
        imageAuthor.text = "Author: \(author)"
        
        favoriteImage.image = image
        favoriteImage.clipsToBounds = true
        favoriteImage.contentMode =  .scaleAspectFill
    }
    
    override func prepareForReuse() {
        imageAuthor.text = nil
        favoriteImage.image = nil
    }
}
