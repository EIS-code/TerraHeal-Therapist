//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class VerificationAlert: ThemeDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var lblMessageDetail: ThemeLabel!
    @IBOutlet weak var btnVerify: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var dialogView: UIView!

    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var btnResend: UnderlineTextButton!

    var verificationData: String = ""

    var onBtnResendTapped : (() -> Void)? = nil
    var onBtnDoneTapped : ((_ code:String) -> Void)? = nil
    var onBtnCancelTapped : (() -> Void)? = nil

    var strEnteredOtp:String = ""

    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0

    func initialize(message:String, data:String) {

        self.lblTitle.text = "VERIFICATION_LBL_TITLE".localized()
        self.lblMessage.text = message
        self.lblMessageDetail.text = "VERIFICATION_MSG_DETAIL".localized() + " " + data
        self.verificationData = data
        self.btnVerify.setTitle("VERIFICATION_BTN_VERIFY".localized(), for: .normal)
        self.btnResend.setTitle("VERIFICATION_BTN_RESEND".localized(), for: .normal)
        self.initialSetup()

    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.lblMessage.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.lblMessageDetail.setFont(name: FontName.Ovo, size: FontSize.label_14)
        self.setupOtpView()
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

    @IBAction func btnResendTapped(_ sender: Any) {
        if self.onBtnResendTapped != nil {
            self.onBtnResendTapped!();
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if strEnteredOtp.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_ENTER_OTP".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(strEnteredOtp);
            }
        }

    }

}
//OTP  Setup
extension VerificationAlert:  OTPFieldViewDelegate {

    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 4
        self.otpTextFieldView.fieldBorderWidth = 1
        self.otpTextFieldView.defaultBorderColor = UIColor.themePrimaryBorder
        self.otpTextFieldView.filledBorderColor = UIColor.themePrimary
        self.otpTextFieldView.cursorColor = UIColor.themePrimary
        self.otpTextFieldView.displayType = .square
        self.otpTextFieldView.fieldSize = 60
        self.otpTextFieldView.separatorSpace = 0
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }

    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }

    func enteredOTP(otp otpString: String) {
        self.strEnteredOtp = otpString
        print("OTPString: \(otpString)")
    }
}


//MARK:   - Interative Animation
extension  VerificationAlert {

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
