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
    var searchData: SearchModel? = nil
    var isFirstLogin = true
    
    private lazy var viewModel: FilmListVM = {
          let vm = FilmListVM()
          vm.delegate = self
          return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func loadData(searchText: String){
        viewModel.getData(searchText: searchText)
    }
    
    func setupUI(){
        navigationController?.navigationBar.topItem?.title = "Anasayfa"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true);
        searchBar.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    static func push(from: UIViewController) {
        if let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmListViewController") as? FilmListViewController {
            from.navigationController?.pushViewController(view, animated: false)
        }
    }
}

extension FilmListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isFirstLogin{
            return searchData?.search?.count ?? 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as? FilmTableViewCell else { return UITableViewCell()}
        if let element = searchData?.search?[indexPath.row] {
            cell.item = element
        }else{
            if searchBar.textField?.text?.isEmpty ?? false {
                cell.emptyItem = "Aradığınız film bulunamadı."
            }else{
                cell.emptyItem = "'\(searchBar.searchTextField.text ?? "")' bulunamadı."
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let title = searchData?.search?[indexPath.row].title {
            FilmDetailViewController.push(from: self, title: title)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FilmListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.view.activityStartAnimating()
        searchBar.isLoading = true
        loadData(searchText: searchText)
    }
}

extension FilmListViewController: FilmListVMDelegate {
    func completed(response: SearchModel) {
        searchBar.isLoading = false
        self.view.activityStopAnimating()
        searchData = response
        isFirstLogin = false
        tableView.reloadData()
    }
 
    func error(error: Error) {
        showError(error: error)
    }
}
