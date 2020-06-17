//
//  SplashViewController.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/16/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: BaseViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var splashBottomTitle: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remoteConfigTitle()
        getRemoteConfigTitle()
        setupUI()
        changeTitle()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func remoteConfigTitle(){
        spinner.startAnimating()
        let defaultValue = ["splashTitle":"Film Demo"]
        remoteConfig.setDefaults(defaultValue as [String : NSObject])
    }
    
    func getRemoteConfigTitle(){
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self]
            (response, error) in
            guard error == nil else { return }
            print(response)
            remoteConfig.activate()
            self.changeTitle()
        }
    }
    
    func changeTitle(){
        if let text = remoteConfig.configValue(forKey: "splashTitle").stringValue {
            if appTitle.text != text {
                appTitle.text = text
                Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(pushMainView), userInfo: nil, repeats: false)
            }
        }
    }
    
    @objc func pushMainView(){
        spinner.stopAnimating()
        if splashBottomTitle.isHidden {
            FilmListViewController.push(from: self)
        }
    }
    
    func setupUI(){
        if !isConnectedToNetwork(){
            splashBottomTitle.text = "Lütfen internet bağlantınızı kontrol edin."
            splashBottomTitle.isHidden = false
        }
    }
}


