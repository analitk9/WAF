//
//  StorageModel.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation

struct StorageModel: Codable {
    var favoriteDict: [String: ElementDetail]
    
    init(){
        favoriteDict = [:]
    }
}




