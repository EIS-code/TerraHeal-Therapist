//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class PaymentVerificationDialog: ThemeDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnVerify: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!

    var verificationData: String = ""
    var onBtnDoneTapped : ((_ data:String) -> Void)? = nil

    var strEnteredData:String = ""
    var onBtnCancelTapped : (() -> Void)? = nil

    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0

    func initialize(title:String, message:String, data:String) {
        self.txtEmail?.placeholder = message
        self.lblTitle.text = title
        self.verificationData = data
        self.btnVerify.setTitle("BTN_CONNECT".localized(), for: .normal)
        self.initialSetup()
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.txtEmail?.delegate = self
        self.addPanGesture(view: self)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDone?.setUpRoundedButton()
    }

    func show(animated:Bool){

        self.isAnimated = animated
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds
        if let topController = Common.appDelegate.getTopViewController() {
            topController.view.addSubview(self)
        }

        if animated {
            self.isUserInteractionEnabled = false
            self.dialogView.alpha = 0.1
            self.dialogView.transform = CGAffineTransform(translationX: 0.0, y: self.frame.maxY)
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                self.dialogView.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.dialogView.alpha = 1.0
            }) { (completion) in



                //self.animationVw.shake()
                self.isUserInteractionEnabled = true
            }
        }
        else {
            self.backgroundView.alpha = 0.66
        }

    }

    func dismiss(){
        if self.isAnimated {
            self.dialogView.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 0.66
            self.dialogView.alpha = 1.0
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseInOut], animations: {

                self.dialogView.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
                self.backgroundView.alpha = 0.0
                self.dialogView.alpha = 0.1

            }) { (completion) in
                self.removeFromSuperview()
            }
        }else{
            self.removeFromSuperview()
        }

    }


    @objc func didTappedOnBackgroundView(){
        if isCancellable {
            dismiss()
        }
    }


    @IBAction func btnDoneTapped(_ sender: Any) {
        strEnteredData = txtEmail.text?.trim() ?? ""
        if strEnteredData.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_INVALID_EMAIL".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(strEnteredData);
            }
        }

    }

}

extension PaymentVerificationDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            _ = txtEmail?.becomeFirstResponder()
        }
        return true
    }
}


//MARK:   - Interative Animation
extension  PaymentVerificationDialog {

    func addPanGesture(view: UIView) {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewPanned(recognizer:))) // will be defined later!
        view.addGestureRecognizer(recognizer)
    }

    func dismissWithInteractiveAnimation() {

    }

    private func directionFromVelocity(_ velocity: CGPoint) -> AnimationDirection {
        guard velocity != .zero else { return .undefined }
        let isVertical = abs(velocity.y) > abs(velocity.x)
        var derivedDirection: AnimationDirection = .undefined
        if isVertical {
            derivedDirection = velocity.y < 0 ? .up : .down
        }
        else {
            derivedDirection = velocity.x < 0 ? .left : .right
        }
        return derivedDirection
    }


    @objc func viewPanned(recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: self)
        let translate: CGPoint = recognizer.translation(in: self)
        let direction:AnimationDirection =  directionFromVelocity(velocity)

        switch recognizer.state {
        case .began:

            if transitionAnimator?.isRunning ?? true {
                transitionAnimator?.stopAnimation(true)
            }
            animationProgress = transitionAnimator?.fractionComplete ??  0
            self.addDissmissAnimation(direction: direction)
            transitionAnimator?.pauseAnimation()
            yPostion = translate.y
        case .changed:
            let totalYSwipe: CGFloat = translate.x - yPostion
            let height: CGFloat = UIScreen.main.bounds.size.height
            let percentage = CGFloat(abs(Float(totalYSwipe))) / height
            animationProgress  = percentage
            transitionAnimator?.fractionComplete = animationProgress

        case .ended, .failed , .cancelled :
            transitionAnimator?.stopAnimation(true)
            self.addDissmissAnimation(direction: direction)
            transitionAnimator?.startAnimation()

        default:
            break
        }
    }
    func addDissmissAnimation(direction:AnimationDirection) {

        print("Direction \(direction)")
        switch  direction {
        case .up:
            print("No Animation")
            transitionAnimator?.stopAnimation(true)
            transitionAnimator?.addAnimations {
                self.dialogView.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.dialogView.alpha = 1.0
            }
            transitionAnimator?.addCompletion({ (position) in
                self.isUserInteractionEnabled = true
            })

        case .down:
            transitionAnimator?.stopAnimation(true)
            transitionAnimator?.addAnimations {
                self.dialogView.transform = CGAffineTransform(translationX:0, y: self.frame.maxY)
                self.backgroundView.alpha = 0.0
                self.dialogView.alpha = 0.1
            }
            transitionAnimator?.addCompletion({ (position) in
                self.removeFromSuperview()
                if self.onBtnCancelTapped != nil {
                    self.onBtnCancelTapped!();
                }
            })
        case .left,.right:
            print("No Animation")
        default:
            print("No Animation")

        }



    }


}
