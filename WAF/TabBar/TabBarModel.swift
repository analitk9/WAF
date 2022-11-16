//
//  TabBarModel.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import UIKit

enum TabBarModel {
    case main
    case favorite
    
    
    var title: String {
        switch self {
        case .main:
          return "Main"
        case .favorite:
           return "Favorite"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "photo.on.rectangle.angled")
        case .favorite:
            return UIImage(systemName: "photo.fill.on.rectangle.fill")
        }
    }
    
    var selectedImage: UIImage? {
        return image
    }
    
}
