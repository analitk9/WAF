//
//  NetworkService.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import Moya

struct NetworkService {
    
  private let provider = MoyaProvider<RequestUnsplash>()
    
    func fetchRandomImageRequest(complition: @escaping ((Result<Response, MoyaError>)->Void)) {
        
        provider.request(.randomImages) { result in
            complition(result)
        }
        
    }
    
    func fetchSearchImageRequest(with param: Request, complition: @escaping ((Result<Response, MoyaError>)->Void)) {
        provider.request(.searchImages(param)) { result in
            complition(result)
        }
    }
    
    func featchDetailImageRequest(with imageID: String,complition: @escaping ((Result<Response, MoyaError>)->Void)) -> Void {
        provider.request(.detailImage(imageID)) { result in
            complition(result)
        }
    }
    
}
