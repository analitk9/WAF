//
//  MainModel.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import UIKit

class MainModel: NSObject {
    var rawDate = [Element]()
    var searchDate: SearchElement? {
        didSet{
            reloadDataHandler?()
        }
    }
    var images: [String: UIImage] = [String: UIImage]() {
        didSet {
            reloadDataHandler?()
        }
    }
    private var searchTimer: Timer?
    private var previousRequest = ""
    var reloadDataHandler: (()->Void)?
    var alertHandler: ((String)->Void)?
    
    let requestProvider = RequestProvider()
    
    func initialRequest(){
        requestProvider.randomImageRequest { elements in
            self.rawDate = elements
            self.rawDate.forEach { element in
                URLSession.shared.dataTask(with: element.urls.regular) { data, response, error in
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.images[element.blurHash] = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    func updateSearch(request: String?) {
        guard let query = request, query.count != 0, previousRequest != query else { return }
        previousRequest = query

        searchTimer?.invalidate()
 
        /// debounce
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
            self?.searchRequest(search: query)
        })
        
    }
    
    func searchRequest(search: String){
        let request = Request(params: ["query" : search])
        requestProvider.searchImagesRequest(with: request) { searchElement in
            guard  searchElement.total != 0 else {
                self.alertHandler?("По запросу \(search) не найдено картинок")
                return
            }
            self.rawDate = searchElement.results
            self.rawDate.forEach { element in
                URLSession.shared.dataTask(with: element.urls.regular) { data, response, error in
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.images[element.blurHash] = image
                        }
                    }
                }.resume()
            }
        }
    }
}


