//
//  FilmDetailVM.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/17/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import Foundation
import Moya

protocol FilmDetailVMDelegate: class {
    func completed(response: MovieModel)
    func error(error: Error)
}

class FilmDetailVM{
    
    weak var delegate: FilmDetailVMDelegate?
    let filmProvider = MoyaProvider<FlickrNetwork>()

    func getData(searchText: String){
        filmProvider.request(.getFilm(searchText: searchText)) { (result) in
            switch result{
            case .success(let response):
                do {
                    print(try response.mapJSON())
                    let data = try JSONDecoder().decode(MovieModel.self, from: response.data)
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
