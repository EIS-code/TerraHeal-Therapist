//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

enum AnimationDirection: Int {    case up, down, left, right, undefined}

class CustomAlert: ThemeDialogView {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var animationVw: UIView!


    var onBtnCancelTapped: (() -> Void)? = nil

    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var xpostion: CGFloat = 0.0

    func initialize(message:String) {
        self.initialSetup()
        self.lblMessage.setFont(name: FontName.Ovo, size: FontSize.label_26)
        lblMessage.text = message
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.addPanGesture(view: animationVw)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
    }

    func show(animated:Bool){

        self.isAnimated = animated
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds

        if let topController = Common.appDelegate.getTopWindow() {
            topController.addSubview(self)
        }

        if animated {
            self.isUserInteractionEnabled = false
            self.animationVw.alpha = 0.1
            let translation = CGAffineTransform(translationX: self.frame.midX, y: 0)
            self.animationVw.transform = translation.rotated(by:-6.0)
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                self.animationVw.transform = CGAffineTransform.identity
                self.animationVw.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
                self.backgroundView.alpha = 0.66
                self.animationVw.alpha = 1.0
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
            self.animationVw.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 0.66
            self.animationVw.alpha = 1.0
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseInOut], animations: {
                let translation = CGAffineTransform(translationX: -self.frame.midX, y: 0)
                self.animationVw.transform = translation.rotated(by: 6.0)
                self.backgroundView.alpha = 0.0
                self.animationVw.alpha = 0.1

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

    @IBAction func btnCalcelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil
        {
            self.onBtnCancelTapped!();
            
        }

    }

}

//MARK:   - Interative Animation
extension  CustomAlert {

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
            derivedDirection = velocity.y < 0 ? .up: .down
        }
        else {
            derivedDirection = velocity.x < 0 ? .left: .right
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
            xpostion = translate.x
        case .changed:
            let totalXSwipe: CGFloat = translate.x - xpostion
            let width: CGFloat = UIScreen.main.bounds.size.width
            let percentage = CGFloat(abs(Float(totalXSwipe))) / width
            animationProgress  = percentage
            transitionAnimator?.fractionComplete = animationProgress

        case .ended, .failed , .cancelled:
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
        case .left:
            transitionAnimator?.stopAnimation(true)

            transitionAnimator?.addAnimations {
                let translation = CGAffineTransform(translationX: -self.frame.midX, y: 0)
                self.animationVw.transform = translation.rotated(by: 6.0)
                self.backgroundView.alpha = 0.0
                self.animationVw.alpha = 0.1
            }
        case .right:
            transitionAnimator?.stopAnimation(true)
            transitionAnimator?.addAnimations {
                let translation = CGAffineTransform(translationX: self.frame.midX, y: 0)
                self.animationVw.transform = translation.rotated(by: -6.0)
                self.backgroundView.alpha = 0.0
                self.animationVw.alpha = 0.1
            }
        case .up,.down:
            print("No Animation")
        default:
            print("No Animation")

        }


        transitionAnimator?.addCompletion({ (position) in
            self.removeFromSuperview()
        })
    }


}
