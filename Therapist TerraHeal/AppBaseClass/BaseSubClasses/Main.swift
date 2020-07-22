//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
// import JDFramework

class MainVC: UIViewController {
   
    @IBOutlet weak var lblTitle: ThemeLabel?
    @IBOutlet weak var btnLeft: FloatingRoundButton?
    @IBOutlet weak var btnRight: ThemeButton?
    @IBOutlet weak var headerGradient: UIView!
    @IBOutlet weak var footerGradient: UIView!


    var topGradientLayer: CAGradientLayer? = nil
    var bottomGradientLayer: CAGradientLayer? = nil

    // MARK: - LifeCycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLeft?.setBackButton()
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.lblTitle?.textColor = .themeDarkText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topGradientLayer?.frame = headerGradient?.bounds ?? CGRect.zero
        bottomGradientLayer?.frame = footerGradient?.bounds ?? CGRect.zero

        
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
    func isViewAvailable() -> Bool {
        return self.view.subviews.count >  0
    }

    func addTopFade() {
        topGradientLayer =  CAGradientLayer()
        let gradientColor = UIColor.white
        topGradientLayer!.frame = headerGradient.bounds
        topGradientLayer!.colors = [gradientColor.withAlphaComponent(1.0).cgColor,gradientColor.withAlphaComponent(0.8).cgColor, gradientColor.withAlphaComponent(0.5).cgColor,gradientColor.withAlphaComponent(0.0).cgColor]
        topGradientLayer!.name = "topGradient"

        if let oldLayer:  CAGradientLayer = self.headerGradient.layer.sublayers?.last(where: { (currentLayer) -> Bool in
            return currentLayer.name == "topGradient"
        }) as?  CAGradientLayer {
            oldLayer.removeFromSuperlayer()
        }

        self.headerGradient.layer.addSublayer(topGradientLayer!)
    }

    func addBottomFade() {
        bottomGradientLayer = CAGradientLayer()
        let gradientColor = UIColor.white
        bottomGradientLayer!.frame = footerGradient.bounds
        bottomGradientLayer!.colors = [gradientColor.withAlphaComponent(0.0).cgColor,gradientColor.withAlphaComponent(0.5).cgColor, gradientColor.withAlphaComponent(0.8).cgColor,gradientColor.withAlphaComponent(1.0).cgColor]
        bottomGradientLayer!.name = "bottomGradient"

        if let oldLayer:  CAGradientLayer = self.footerGradient.layer.sublayers?.last(where: { (currentLayer) -> Bool in
            return currentLayer.name == "bottomGradient"
        }) as?  CAGradientLayer {
            oldLayer.removeFromSuperlayer()
        }

        self.footerGradient.layer.addSublayer(bottomGradientLayer!)
    }

 }

//MARK: Location Observer
extension MainVC {
    func addLocationObserver() {
        Common.nCd.removeObserver(self,
                               name: Common.locationUpdateNtfNm,
                               object: LC.default)
        Common.nCd.removeObserver(self,
                               name: Common.locationFailNtfNm,
                               object: LC.default)

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
    @objc func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        
    }

    @objc func locationFail(_ ntf: Notification = Common.defaultNtf) {

    }
}




class CollectionCell: UICollectionViewCell {
    var parentVC: UIViewController? = nil
}

class TableCell: UITableViewCell {
    var parentVC: UIViewController? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}




