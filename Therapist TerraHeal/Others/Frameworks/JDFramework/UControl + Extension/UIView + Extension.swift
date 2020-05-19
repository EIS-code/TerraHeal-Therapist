//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    func toCall()  {
        if let url = URL(string: "tel://\(self)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
        }
    }
}

public extension UIView {
    func  setRound(withBorderColor:UIColor=UIColor.clear, andCornerRadious:CGFloat = 0.0, borderWidth:CGFloat = 1.0) {
        
        if andCornerRadious==0.0
        {
            var frame:CGRect = self.frame;
            frame.size.height=min(self.frame.size.width, self.frame.size.height) ;
            frame.size.width=frame.size.height;
            self.frame=frame;
            self.layer.cornerRadius=self.layer.frame.size.width/2;
        }
        else
        {
            self.layer.cornerRadius=andCornerRadious;
        }
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true;
        self.layer.borderColor = withBorderColor.cgColor
    }

}

// MARK: Nib Extension
public extension UIView {

    func clean() {
        
        for subvw in self.subviews {
            subvw.clean()
        }
        self.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }
     class func fromNib<T: UIView>() -> T {
        
        let type = self.self
        let nibObjs = Bundle.main.loadNibNamed(type.name, owner: nil, options: nil)

        if nibObjs != nil {
            for nibObj in nibObjs! {
                let obj = nibObj as AnyObject

                if obj.isKind(of: type) {
                    return obj as! T
                }
            }
        }

        return type.init() as! T
    }

     class func nib() -> UINib {
        
        let type = self.self
        return UINib(nibName: type.name, bundle: nil)
    }

    func gone(animated: Bool = true) {
        if animated {
            fadeOut()
        } else {
            self.isHidden = true
        }
    }

    func visible(animated: Bool = true) {
        if animated {
            fadeIn()
        } else {
            self.isHidden = false
        }
    }

    func fadeIn(duration: TimeInterval = 0.5,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        self.isHidden = false
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.alpha = 1.0

        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.5,
                 delay: TimeInterval = 0.0,
                 completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.alpha = 0.0
                        self.isHidden = true
        }, completion: completion)
    }
}





extension UITableView {

    func reloadData(_ completion: (() -> Void)?) {
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                completion?()
            })
            self.reloadData()
            CATransaction.commit()
        }
    }

    func reloadData(widthToFit cntrnt: NSLayoutConstraint?,
                    _ completion: (() -> Void)?) {
        DispatchQueue.main.async {
            self.contentOffset = CGPoint.zero
            self.reloadData({
                cntrnt?.constant = self.contentSize.width
                self.superview?.layoutIfNeeded()

                if self.isHEqualToCH {
                    completion?()
                }
                else {
                    self.reloadData(widthToFit: cntrnt, completion)
                }
            })
        }
    }

    func reloadData(heightToFit cntrnt: NSLayoutConstraint?,
                    _ completion: (() -> Void)?) {
        DispatchQueue.main.async {
            self.contentOffset = CGPoint.zero
            self.reloadData({
                cntrnt?.constant = self.contentSize.height
                self.superview?.layoutIfNeeded()

                if self.isHEqualToCH {
                    completion?()
                }
                else {
                    self.reloadData(heightToFit: cntrnt, completion)
                }
            })
        }
    }
}

extension UIScrollView {

    var isWEqualToCW: Bool {
        get {
            return abs(ceil(self.frame.width)-ceil(self.contentSize.width)) <= 1.0
        }
    }

    var isHEqualToCH: Bool {
        get {
            return abs(ceil(self.frame.height)-ceil(self.contentSize.height)) <= 1.0
        }
    }

}



