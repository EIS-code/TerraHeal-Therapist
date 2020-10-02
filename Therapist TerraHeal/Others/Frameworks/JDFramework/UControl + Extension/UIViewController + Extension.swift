//
//  UIViewController + Extension.swift
//  StringExtension
//
//  Created by Jaydeep on 30/11/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    class var storyboardID : String {
        
        return "\(self)"
    }
}

public extension UIViewController {

    func clean() {
        
        for child in self.children {
            child.clean()
        }

        if self.isKind(of: UINavigationController.self) {
            (self as! UINavigationController).viewControllers = []
        }

        if self.isKind(of: UITabBarController.self) {
            (self as! UITabBarController).viewControllers = []
        }

        self.view.clean()
        self.dismiss(animated: false, completion: nil)
        self.removeFromParent()
        NotificationCenter.default.removeObserver(self)
    }

    class func fromNib<T: UIViewController>() -> T {
        
        let type = self.self
        return type.init(nibName: type.name, bundle: nil) as! T
    }
}


@nonobjc extension UIViewController {
    func add(_ child: UIViewController, view: UIView) {
        addChild(child)
        child.view.frame = view.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
