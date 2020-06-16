//
//  FilmListVM.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/16/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import Foundation
import Moya

protocol FilmListVMDelegate: class {
    func completed(response: SearchModel)
    func error(error: Error)
}

class FilmListVM{
    
    weak var delegate: FilmListVMDelegate?
    let filmProvider = MoyaProvider<FlickrNetwork>()

    func getData(searchText: String){
        filmProvider.request(.getFilm(searchText: searchText)) { (result) in
            switch result{
            case .success(let response):
                do {
                    print(try response.mapJSON())
                    let data = try JSONDecoder().decode(SearchModel.self, from: response.data)
                    self.delegate?.completed(response: data)
                } catch let error {
                    self.delegate?.error(error: error)
                }
            case .failure(let error):
                self.delegate?.error(error: error)
            }
        }
    }
}
