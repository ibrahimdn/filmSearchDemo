//
//  FilmDetailViewController.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/16/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import UIKit
import Firebase

class FilmDetailViewController: BaseViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var actorsLbl: UILabel!
    @IBOutlet weak var releasedDate: UILabel!
    @IBOutlet weak var plot: UILabel!
    var movieTitle: String = ""
    
    private lazy var viewModel: FilmDetailVM = {
        let vm = FilmDetailVM()
        vm.delegate = self
        return vm
    }()
    
    static func push(from: UIViewController, title: String) {
        if let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmDetailViewController") as? FilmDetailViewController {
            view.movieTitle = title
            from.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieTitle
        setupUI()
        loadData(searchText: movieTitle)
    }
    
    func setupUI(){
        movieImage.image = UIImage()
        titleLbl.text = ""
        rating.text = ""
        actorsLbl.text = ""
        releasedDate.text = ""
        plot.text = ""
    }
    
    func loadData(searchText: String){
        self.view.activityStartAnimating()
        if movieTitle != "" {
            viewModel.getData(searchText: searchText)
        }
     }
    
    func setData(data: MovieModel){
        movieImage.kf.indicatorType = .activity
         if let url =  URL(string: data.poster ?? String()) {
            movieImage.kf.setImage(with: url)
        }
        titleLbl.text = data.title
        rating.text = data.imdbRating
        actorsLbl.text = data.actors
        releasedDate.text = data.released
        plot.text = data.plot
        
//        MARK: FIREBASE
        
        let param: [String: Any] = ["title": data.title ?? "",
                                    "actors": data.actors ?? "",
                                    "rating": data.imdbRating ?? "",
                                    "releasedDate": data.released ?? ""]
        
        Analytics.logEvent(AnalyticsEventSelectItem, parameters: param)
        self.view.activityStopAnimating()
    }
}


extension FilmDetailViewController: FilmDetailVMDelegate{
    func completed(response: MovieModel) {
        setData(data: response)
    }
    
    func error(error: Error) {
        showError(error: error)
    }
}
