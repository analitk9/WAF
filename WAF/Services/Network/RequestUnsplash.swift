//
//  Unsplash.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import Moya

enum RequestUnsplash {
    case randomImages
    case searchImages(Request)
    case detailImage(String)
}

struct Request {
    let params: [String: Any]
}

extension RequestUnsplash: TargetType {
    
    private static let host = "api.unsplash.com"
    private static let url = "https://\(RequestUnsplash.host)"
    private static let apiKey = "1qr8uiD2Xknf5-Q4ZmFTPwM6fij168FM11jXDmknLSA"
    
    var baseURL: URL {
        URL(string: RequestUnsplash.url)!
    }
    
    var path: String {
        switch self {
        case .randomImages:
            return "/photos"
        case .searchImages:
            return "/search/photos/"
        case .detailImage(let id):
            return "/photos/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .randomImages, .searchImages, .detailImage:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .randomImages:
            return .requestPlain
        case   .searchImages(let request):
            return .requestParameters(parameters: request.params, encoding: URLEncoding.default)
        case  .detailImage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        ["Authorization": "Client-ID \(Self.apiKey)"]
    }
    
    
}
