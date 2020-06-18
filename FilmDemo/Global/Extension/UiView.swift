//
//  UiView.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/18/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import Foundation
import UIKit

extension UIView{

    func activityStartAnimating() {
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.tag = 1001
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        self.addSubview(activityIndicator)
    }

    func activityStopAnimating() {
        if let activity = viewWithTag(1001){
            activity.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    
    func addOverlay(px: CGFloat) {
        self.layer.cornerRadius = px
        self.clipsToBounds = true
    }
    
    func addShadowAndOverlay(px: CGFloat, color: UIColor) {
         addOverlay(px: px)
         layer.masksToBounds = false
         layer.shadowColor = color.cgColor
         layer.shadowOffset = CGSize(width: 1, height: 2)
         layer.shadowRadius = 3
         layer.shadowOpacity = 0.3
     }
}
