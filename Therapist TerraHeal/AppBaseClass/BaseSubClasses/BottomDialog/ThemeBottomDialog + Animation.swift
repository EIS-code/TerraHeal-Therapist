//
//  ThemeBottomDialog + Animation.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 18/08/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import  UIKit

//MARK: -Animation to Show/Hide Dialog

extension ThemeBottomDialogView {
    @objc func show(animated:Bool){
        self.isAnimated = animated
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds
        
        if let topController = Common.appDelegate.getCurrentViewController() {
            topController.view.endEditing(true)
           // Common.appDelegate.window?.addSubview(self)
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
}
//MARK:   - Interative Animation
extension  ThemeBottomDialogView {
    
    func addPanGesture(view: UIView) {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewPanned(recognizer:))) // will be defined later!
        view.addGestureRecognizer(recognizer)
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
        let velocity = recognizer.velocity(in: dialogView)
        let translate: CGPoint = recognizer.translation(in: dialogView)
        let direction:AnimationDirection =  directionFromVelocity(velocity)
        
        switch recognizer.state {
        case .began:
            if transitionAnimator?.isRunning ?? true {
                transitionAnimator?.stopAnimation(true)
            }
            animationProgress = transitionAnimator?.fractionComplete ??  0
            self.upDownAnimation(direction: direction)
            transitionAnimator?.pauseAnimation()
            yPostion = translate.y
        case .changed:
            let totalYSwipe: CGFloat = translate.y - yPostion
            let height: CGFloat = UIScreen.main.bounds.height
            let percentage = CGFloat(abs(Float(totalYSwipe))) / height
            animationProgress  = percentage
            transitionAnimator?.fractionComplete = animationProgress
        case .ended, .failed , .cancelled:
            _ = transitionAnimator!.fractionComplete
            if direction == .up {
                transitionAnimator?.stopAnimation(true)
                self.upDownAnimation(direction: AnimationDirection.up)
                transitionAnimator?.startAnimation()
            } else if direction == .down {
                transitionAnimator?.stopAnimation(true)
                self.upDownAnimation(direction: AnimationDirection.down)
                /* if fractionComplete < 0.1 {
                    self.upDownAnimation(direction: AnimationDirection.up)
                 } else {
                 self.upDownAnimation(direction: AnimationDirection.down)
                 }*/
                transitionAnimator?.startAnimation()
            } else {
                
            }
        default:
            break
        }
    }
    
    func upDownAnimation(direction:AnimationDirection) {
        print("Animation \(direction.rawValue)")
        switch  direction {
        case .up:
            self.doStepUpAnimation()
        case .down:
            self.doStepDownAnimation()
        case .left:
            print("No Animation Leftt")
        case .right:
            print("No Animation Right")
        default:
            print("No Animation")
        }
    }
    
    func doStepDownAnimation() {
        self.downDialogAnimation()
    }
    
    func downDialogAnimation() {
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
    }
    func doStepUpAnimation() {
        if arrForSteps.isEmpty || isFixedHeightDialog {
            self.upDialogAnimation()
        } else {
            var nextHeight:  CGFloat = self.dialogHeight.constant
            if let index = arrForSteps.firstIndex(of: self.dialogHeight.constant / UIScreen.main.bounds.height ) {
                if index < (arrForSteps.count-1) {
                    nextHeight = (arrForSteps[index + 1] * UIScreen.main.bounds.height)
                }
            }
            if  nextHeight != self.dialogHeight.constant {
                UIView.animate(withDuration: 0.5, animations: {
                    self.setDialogHeight(height: nextHeight / UIScreen.main.bounds.height)
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
    func setDataForStepUpAnimation(data:[CGFloat] = [0.75,0.95]) {
        self.arrForSteps = data
        self.isFixedHeightDialog = false
        self.setDialogHeight(height: (data.first ?? 0.75))
    }
    func setDialogHeight(height:CGFloat){
        self.dialogHeight?.constant = height * UIScreen.main.bounds.height
    }
    func upDialogAnimation() {
        transitionAnimator?.stopAnimation(true)
        transitionAnimator?.addAnimations {
            self.dialogView.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 0.66
            self.dialogView.alpha = 1.0
        }
        transitionAnimator?.addCompletion({ (position) in
            self.isUserInteractionEnabled = true
        })
    }
}

