//
//  RequestProvider.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation

struct RequestProvider {
    
    //        detailImageRequest(with: "0P-cY9tUNnY")
    //        let param: [String: Any] = ["query":"query","lang":"ru"]
    //        let request = Request(params: param)
    //        searchImagesRequest(with: request)
    
    private let networkService = NetworkService()
    
    
    func searchImagesRequest(with params: Request, complition: @escaping ((SearchElement)->Void)) {
        networkService.fetchSearchImageRequest(with: params) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let images = try  response.map(SearchElement.self)
                        complition(images)
                    }catch {
                        print( error.localizedDescription)
                    }
                    
                }
            }
        }
        
    }
    
    func detailImageRequest(with imageId: String, complition: @escaping((ElementDetail)->Void )  ){
        networkService.featchDetailImageRequest(with: imageId) {  result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let images = try  response.map(ElementDetail.self)
                        complition(images)
                        
                    }catch {
                        print( error.localizedDescription)
                    }
                    
                }
            }
            
        }
        
    }
    
    func randomImageRequest(complition: @escaping ([Element])-> Void) {
        networkService.fetchRandomImageRequest { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let images = try  response.map(Array<Element>.self)
                        complition(images)
                    }catch {
                        print( error.localizedDescription)
                    }
                    
                }
            }
            
        }
    }
    
    
    
}
