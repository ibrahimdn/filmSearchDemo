//
//  Network.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/16/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import Foundation
import Moya

let key = "62abf13c"

public enum FlickrNetwork {
    case getFilm(searchText: String)
    case search(text: String)
}

extension FlickrNetwork: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://www.omdbapi.com/")!
    }

    public var path: String {
        switch self {
        case .getFilm: return ""
        case .search: return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getFilm: return .get
        case .search: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getFilm(let searchText):
            let param = ["t": searchText,
                         "apikey": key]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
            
        case .search(let text):
             let param = ["s": text,
                          "apikey": key]
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
