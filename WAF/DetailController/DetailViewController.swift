//
//  DetailViewController.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    
    private let model = DetailModel()
   
    
    let imageId: String
    let image: UIImage
    
    let scrollView: UIScrollView = {
        let scroll =  UIScrollView()
        scroll.isScrollEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let  mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let descriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    let buttonStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let createDateLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        return label
    }()
    
    let downloadLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        return label
    }()
    
    let addFavouritesButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Add favorite", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let removeFavouritesButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Remove favorite", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(imageId: String, image: UIImage) {
        self.imageId = imageId
        self.image = image
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.detailImageRequest(imageId: imageId)
        model.dataHandler = {
            self.setupUI()
            self.setupCoordinate()
        }
        configureUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.loadModel()
        setupEnableButton()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureLayout()
    }
    

    
    private func setupUI (){
        detailImageView.image = image
        guard let imageDetail = model.imageDetail else {return}
        let sampleDate = ISO8601DateFormatter().date(from:imageDetail.createdAt)!
        let localizedDate = DateFormatter.localizedString(from: sampleDate, dateStyle: .medium, timeStyle: .none)
        authorLabel.text = "Author: \(String(describing: imageDetail.user.name))"
        createDateLabel.text = "Create date: \(localizedDate)"
        downloadLabel.text = "Download: \(String(describing: imageDetail.downloads))"
        
       setupEnableButton()
    }
    
   private func setupEnableButton (){
       addFavouritesButton.layer.opacity = !model.isFavourite ? 1.0 : 0.5
       addFavouritesButton.isEnabled = !model.isFavourite
       removeFavouritesButton.isEnabled = model.isFavourite
       removeFavouritesButton.layer.opacity = model.isFavourite ? 1.0 : 0.5
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        buttonStack.addArrangedSubview(addFavouritesButton)
        buttonStack.addArrangedSubview(removeFavouritesButton)
        descriptionStack.addArrangedSubview(authorLabel)
        descriptionStack.addArrangedSubview(createDateLabel)
        descriptionStack.addArrangedSubview(downloadLabel)
        descriptionStack.addArrangedSubview(buttonStack)
        addFavouritesButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        removeFavouritesButton.addTarget(self, action: #selector(removeFavorite), for: .touchUpInside)
        
        contentView.addSubviews([detailImageView, mapView, descriptionStack])
    }
    
    private func setupCoordinate(){
        guard let latitude =  model.imageDetail?.location.position.latitude,
              let longitude = model.imageDetail?.location.position.longitude  else { return }
        
        let centerCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude:  longitude)
            mapView.setCenter(centerCoordinates, animated: true)
            let region = MKCoordinateRegion(center: centerCoordinates, latitudinalMeters: 50000, longitudinalMeters: 50000)
            mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Photo place"
        annotation.coordinate = centerCoordinates
        mapView.addAnnotation(annotation)

    }
    
    private func configureLayout() {
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        
        [
            frameGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameGuide.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            frameGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            contentGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentGuide.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),

            detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            detailImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            detailImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            detailImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mapView.topAnchor.constraint(equalTo: detailImageView.bottomAnchor,constant: 10),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mapView.heightAnchor.constraint(equalToConstant: view.bounds.width/2),
            
            descriptionStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionStack.topAnchor.constraint(equalTo: mapView.bottomAnchor,constant: 10),
            descriptionStack.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -10),
            descriptionStack.heightAnchor.constraint(equalToConstant: view.bounds.width/3),
            
            contentView.bottomAnchor.constraint(equalTo: descriptionStack.bottomAnchor),
       
        ].forEach { $0.isActive = true }
    }
    
    @objc func addFavorite(){
        model.saveFavorite(image: image)
        setupEnableButton()
    }
    
    @objc func removeFavorite(){

        model.removeFavorite(image: image)
        setupEnableButton()
        
    }
    
}
