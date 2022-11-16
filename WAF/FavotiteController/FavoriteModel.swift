//
//  FavoriteModel.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import UIKit

class FavoriteModel {
    
    var favorites: [ElementDetail] =  []
    var images: [UIImage] = [] {
        didSet{
            dataHandler?()
        }
    }
    private var storageModel = StorageModel() {
        didSet{
            favorites  = Array<ElementDetail>(storageModel.favoriteDict.values)
            images = storageModel.favoriteDict.keys.map { key in
                favoriteStorage.loadImage(with: key) ?? UIImage(blurHash: self.storageModel.favoriteDict[key]!.blurHash, size: CGSize(width: 50, height: 50))!
            }
        }
    }
    private let favoriteStorage = FavoriteStorage()
    
    var dataHandler: (()->Void)?
    
    init(){
        loadModel()
    }
    
    func loadModel(){
        if let favStor =  favoriteStorage.loadData() {
            self.storageModel = favStor
        }
    }
    
    
    
    
    
}


