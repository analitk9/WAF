//
//  DetailModel.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import UIKit

class DetailModel {
    
    let requestProvider = RequestProvider()
    var isFavourite: Bool {
        guard let imageDetail = imageDetail else {return false}
        return  favorites.favoriteDict[imageDetail.id] != nil
    }
    var imageDetail: ElementDetail?{
        didSet{
            dataHandler?()
        }
    }
    private let favoriteStorage = FavoriteStorage()
    private var favorites = StorageModel()
    
    var dataHandler: (()->Void)?
    init(){
        loadModel()
    }
    
    func loadModel(){
        if let favStor =  favoriteStorage.loadData() {
            self.favorites = favStor
        }
    }
    func detailImageRequest(imageId: String){
        requestProvider.detailImageRequest(with: imageId) { imageDetail in
            self.imageDetail = imageDetail
        }
    }
    
    func saveFavorite(image: UIImage){
        guard let imageDetail = imageDetail else {
            return
        }
        favorites.favoriteDict[imageDetail.id] = imageDetail
        favoriteStorage.saveData(favorites)
        favoriteStorage.saveImage(image, with: imageDetail.id)
    }
    
    func removeFavorite(image: UIImage){
        guard let imageDetail = imageDetail else {
            return
        }
        if favoriteStorage.deleteImage(with: imageDetail.id) {
            favorites.favoriteDict[imageDetail.id] = nil
            favoriteStorage.saveData(favorites)
        }else {
            print("wrong delete image")
        }
    }
    
    
}
