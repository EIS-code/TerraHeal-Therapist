//
//  ThemeBottomDialog.swift
//  Terra Heal
//
//  Created by Jaydeep on 09/06/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

class ThemeDialogView: ThemeView {
    var isCancellable:Bool = false
    var isAnimated:Bool = false
    deinit {
        print("\(self) \(#function)")
    }
}


class ThemeBottomDialogView: ThemeView {
    
    //Title View
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var vwTopBar: UIView!
    @IBOutlet weak var topBarSpace: NSLayoutConstraint!
    //Top Gradient
    @IBOutlet weak var stkHeader: UIView!
    
    //Cancel Button
    @IBOutlet weak var btnCancel: DialogCancelButton!
    //Done Button
    @IBOutlet weak var btnDone: DialogFilledRoundedButton!
    @IBOutlet weak var btnDoneFloating: DialogFloatingProceedButton!
    @IBOutlet weak var btnNext: ThemeButton!
    //Footer Gradient
    @IBOutlet weak var stkButtons: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var dialogHeight: NSLayoutConstraint!
    @IBOutlet weak var scrDialogVw: UIScrollView!
    @IBOutlet weak var headerGradient: ThemeTopGradientView!
    @IBOutlet weak var footerGradient: ThemeBottomGradientView!
   
    @IBOutlet weak var hwHeaderGradient: NSLayoutConstraint!
    @IBOutlet weak var hwFooterGradient: NSLayoutConstraint!
    var onBtnCancelTapped: (() -> Void)? = nil
    var arrForSteps: [CGFloat]  = []
    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0
    var isCancellable:Bool = false
    var isAnimated:Bool = false
    var isFixedHeightDialog: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTopBar()
        vwTopBar?.backgroundColor = UIColor.themeDarkText
        self.dialogView.clipsToBounds = true
        self.headerGradient?.enableGradient = false
        if btnDoneFloating != nil {
                (self.stkButtons as? UIStackView)?.spacing = 30
        } else {
            (self.stkButtons as? UIStackView)?.spacing = 24
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.hwHeaderGradient?.constant = (stkHeader?.bounds.height ?? 0) + 20
        self.hwFooterGradient?.constant = (stkButtons?.bounds.height ?? 0) + 20
        self.vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
        self.dialogView?.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
        self.scrDialogVw?.contentInset = self.getGradientInset()
    }
    
    deinit {
        print("\(self) \(#function)")
    }
    
    func setupTopBar(isShow:Bool = true, topSpace:CGFloat = 18) {
        self.vwTopBar?.isHidden = !isShow
        self.topBarSpace?.constant = JDDeviceHelper.offseter(offset: topSpace)
    }
    
    func initialSetup() {
        self.lblTitle?.textColor = UIColor.themeDarkText
        self.dialogView?.backgroundColor = UIColor.themeDialogBackground
        self.backgroundColor = .clear
        self.backgroundView?.backgroundColor = UIColor.black
        self.backgroundView?.alpha = 0.0
        self.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        self.addPanGesture(view: self.dialogView)
        self.transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.btnNext?.setFont(name: FontName.SemiBold, size: FontSize.button_21)
        self.btnDone?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.dialogView?.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
    }
    
    
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil {
            self.onBtnCancelTapped!();
        }
    }
    @objc func didTappedOnBackgroundView(){
        if isCancellable {
            dismiss()
        }
    }
    
    func getGradientInset() -> UIEdgeInsets {
       return UIEdgeInsets.init(top: self.getTopInset(), left: 0, bottom: self.getBottomInset(), right: 0)
    }
    
    func getTopInset() -> CGFloat{
        /*
           if headerGradient != nil {
               if headerGradient!.enableGradient {
                   return (stkHeader?.bounds.height ?? 0) + topBarSpace.constant + 20
                
               } else {
                   return 0
               }
           }*/
        
           return 0
       }
       
       
    func getBottomInset() -> CGFloat{
           if footerGradient != nil {
               if footerGradient!.enableGradient {
                   return (stkButtons?.bounds.height ?? 0) + 20
               } else {
                   return 0
               }
           }
           return 0
    }
}




