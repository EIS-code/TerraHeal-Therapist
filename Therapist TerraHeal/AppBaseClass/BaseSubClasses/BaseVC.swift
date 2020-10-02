//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
// import JDFramework

class BaseVC: UIViewController {
   
    @IBOutlet weak var lblTitle: ThemeLabel?
    @IBOutlet weak var btnLeft: BackButton?
    @IBOutlet weak var btnRight: ThemeButton?
    @IBOutlet weak var vwNavigationBar: ThemeView!
    @IBOutlet weak var headerGradient: ThemeTopGradientView!
    @IBOutlet weak var footerGradient: ThemeBottomGradientView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var gradientView: UIView!
    // MARK: - LifeCycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vwNavigationBar?.backgroundColor = .themeBackground
        self.setBackground(color: .themeBackground)
        self.lblTitle?.textColor = UIColor.themeNavigationTitle
        self.lblTitle?.textColor = UIColor.themeDarkText
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.header)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.mainScrollView?.contentInset = self.getGradientInset()
        }
    }
    
    func getGradientInset() -> UIEdgeInsets {
        return UIEdgeInsets.init(top: self.getTopInset(), left: 0, bottom: self.getBottomInset(), right: 0)
    }
    
    func getTopInset() -> CGFloat{
        if headerGradient != nil {
            if headerGradient!.enableGradient {
                return headerGradient!.frame.height
            } else {
                return 0
            }
        }
        return 0
    }
    
    func getBottomInset() -> CGFloat{
        if footerGradient != nil {
            if footerGradient!.enableGradient {
                return footerGradient!.frame.height
            } else {
                return 0
            }
        }
        return 0
    }
    
    // MARK: - StatusBar
    deinit {
        print("\(self) \(#function)")
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    // MARK: - IBAction
    @IBAction func btnLeftTapped(_ btn: UIButton = UIButton()) {
    }
    
    @IBAction func btnRightTapped(_ btn: UIButton = UIButton()) {
    }

    func setTitle(title: String) {
        lblTitle?.text = title
        lblTitle?.textAlignment = .center
    }
    func setBackground(color: UIColor) {
        self.view?.backgroundColor = color
    }
    func isViewAvailable() -> Bool {
        return self.view.subviews.count >  0
    }

    
    func hideGradient() {
        self.headerGradient.isHidden = true
        self.footerGradient.isHidden = true
    }
    func showGradient() {
        self.headerGradient.isHidden = false
        self.footerGradient.isHidden = false
    }
}

//MARK: Location Observer
extension BaseVC {
    func addLocationObserver() {
        self.removeLocationObserver()
        unowned let _self = self
        Common.nCd.addObserver(_self,
                            selector: #selector(_self.locationUpdate(_:)),
                            name: Common.locationUpdateNtfNm,
                            object: LC.default)
        Common.nCd.addObserver(_self,
                            selector: #selector(_self.locationFail(_:)),
                            name: Common.locationFailNtfNm,
                            object: LC.default)
    }
    func removeLocationObserver() {
        Common.nCd.removeObserver(self,
                                      name: Common.locationUpdateNtfNm,
                                      object: LC.default)
        Common.nCd.removeObserver(self,
                                      name: Common.locationFailNtfNm,
                                      object: LC.default)

    }
    @objc func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        
    }

    @objc func locationFail(_ ntf: Notification = Common.defaultNtf) {

    }
}




class CollectionCell: UICollectionViewCell {
    var parentVC: UIViewController? = nil
}





