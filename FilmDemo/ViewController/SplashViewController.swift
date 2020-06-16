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
        changeTitle()
        getRemoteConfigTitle()
        setupUI()
    }
    
    func remoteConfigTitle(){
        spinner.startAnimating()
        let defaultValue = ["splashTitle":"Film Demo"]
        remoteConfig.setDefaults(defaultValue as [String : NSObject])
    }
    
    func getRemoteConfigTitle(){
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self]
            (response, error) in
            self.spinner.stopAnimating()
            guard error == nil else { return }
            print(response)
            remoteConfig.activate()
            self.changeTitle()
        }
    }
    
    func changeTitle(){
        spinner.stopAnimating()
        if let text = remoteConfig.configValue(forKey: "splashTitle").stringValue {
            appTitle.text = text
        }
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(pushMainView), userInfo: nil, repeats: false)
    }
    
    @objc func pushMainView(){
        FilmListViewController.push(from: self)
    }
    
    func setupUI(){
        if !isConnectedToNetwork(){
            splashBottomTitle.text = "Lütfen internet bağlantınızı kontrol edin."
            splashBottomTitle.isHidden = false
        }
    }

   

}


