//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//


import Foundation
import UIKit


class Loader: NSObject {
    
    
    static var mainView = UIView();


    static func showLoading(color: UIColor = UIColor.white){
        DispatchQueue.main.async {

            
            if let window = UIApplication.shared.keyWindow {
                window.endEditing(true)
                if let view = window.viewWithTag(701) {
                    window.bringSubviewToFront(view)
                    print("Loader Bring Front")
                }
                else {
                    self.mainView.frame = UIScreen.main.bounds
                    self.mainView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                    let animationView: LoaderDialog = LoaderDialog.fromNib()
                    animationView.initialize(message: "Progress")
                    /*let stkVw = Loader.getGetContetview(text: "Progress")
                    stkVw.center = animationView.center*/

                    self.mainView.addSubview(animationView)
                    animationView.center = self.mainView.center
                    
                   /* if let activityIndicator: UIActivityIndicatorView = self.mainView.viewWithTag(701) as? UIActivityIndicatorView {
                        activityIndicator.startAnimating()
                    } else {
                        let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
                        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                        activityIndicator.center = mainView.center
                        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                        activityIndicator.style = .whiteLarge
                        activityIndicator.hidesWhenStopped = false
                        activityIndicator.color = UIColor.white
                        activityIndicator.tag = 701
                        self.mainView.addSubview(activityIndicator)
                        activityIndicator.startAnimating()
                        
                    }*/
                    self.mainView.tag = 701
                    window.addSubview(mainView)
                    print("Loader Added")
                }
            }
        }
    }

    static func hideLoading(){
        DispatchQueue.main.async {
            mainView.removeFromSuperview()
            print("Loader Removed")
            UIApplication.shared.windows.last?.viewWithTag(701)?.removeFromSuperview()
            UIApplication.shared.keyWindow?.viewWithTag(701)?.removeFromSuperview()
        }
    }


}




