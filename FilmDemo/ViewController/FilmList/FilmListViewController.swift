//
//  FilmListViewController.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/16/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import UIKit
class FilmListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
        
    private lazy var viewModel: FilmListVM = {
          let vm = FilmListVM()
          vm.delegate = self
          return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Little Flickr"
        setupUI()
    }
    
    func loadData(searchText: String){
        viewModel.getData(searchText: searchText)
    }
    
    func setupUI(){
        searchBar.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    static func push(from: UIViewController) {
        if let loginBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmListViewController") as? FilmListViewController {
            from.present(loginBoard, animated: true)
        }
    }
    
}

extension FilmListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as? FilmTableViewCell else { return UITableViewCell()}
        return cell
    }
}

extension FilmListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData(searchText: searchText)
    }

}

extension FilmListViewController: FilmListVMDelegate {
    func completed(response: SearchModel) {
        print(response)
    }
 
    func error(error: Error) {
        showError(error: error)
    }
    
}
