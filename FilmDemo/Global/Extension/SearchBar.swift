//
//  SearchBar.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/17/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {

    public var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            let subViews = subviews.flatMap { $0.subviews }
            guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
                return nil
            }
            return textField
        }
    }

    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }

    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .large)
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                    newActivityIndicator.startAnimating()
                    if #available(iOS 13.0, *) {
                        newActivityIndicator.backgroundColor = UIColor.systemGroupedBackground
                    }else {
                        newActivityIndicator.backgroundColor = UIColor.groupTableViewBackground
                    }
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
