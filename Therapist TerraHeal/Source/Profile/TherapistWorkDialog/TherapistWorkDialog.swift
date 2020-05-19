//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class TherapistWorkDialog: ThemeDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnVerify: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnTherapies: ThemeButton!
    @IBOutlet weak var btnMassages: ThemeButton!
    var verificationData: String = ""
    var onBtnDoneTapped : ((_ messages:[WorkDetails],_ therapies:[WorkDetails]) -> Void)? = nil
    var onBtnCancelTapped : (() -> Void)? = nil
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0


    var arrForMassages:[WorkDetails] =  [
            WorkDetails(id: 0, name: "Massage\nName", isSelected: false, image: nil),
            WorkDetails(id: 1, name: "Massage\nName", isSelected: false, image: nil),
            WorkDetails(id: 2, name: "Massage\nName", isSelected: false, image: nil),
            WorkDetails(id: 3, name: "Massage\nName", isSelected: false, image: nil),
            WorkDetails(id: 4, name: "Massage\nName", isSelected: false, image: nil),
            WorkDetails(id: 5, name: "Massage\nName", isSelected: false, image: nil),
            WorkDetails(id: 6, name: "Massage\nName", isSelected: false, image: nil),
            WorkDetails(id: 7, name: "Massage\nName", isSelected: false, image: nil)
    ]

    var arrForTherapies:[WorkDetails] =  [
        WorkDetails(id: 0, name: "Therapy\nName", isSelected: false, image: nil),
        WorkDetails(id: 1, name: "Therapy\nName", isSelected: false, image: nil),
        WorkDetails(id: 2, name: "Therapy\nName", isSelected: false, image: nil),
        WorkDetails(id: 3, name: "Therapy\nName", isSelected: false, image: nil),
        WorkDetails(id: 4, name: "Therapy\nName", isSelected: false, image: nil),
        WorkDetails(id: 5, name: "Therapy\nName", isSelected: false, image: nil),
        WorkDetails(id: 6, name: "Therapy\nName", isSelected: false, image: nil),
        WorkDetails(id: 7, name: "Therapy\nName", isSelected: false, image: nil)
    ]

    var selectedTherapies:[WorkDetails]  = []
    var selectedMassages:[WorkDetails]  = []
    var filteredArray:[WorkDetails] = []
    var isMassageSelected: Bool = true

    func initialize(selectedMassages:[WorkDetails], selectedTherapies:[WorkDetails], data:String) {


        self.lblTitle.text = "T_PROFILE_WORK_LBL_TITLE".localized()
        self.verificationData = data
        self.btnTherapies.setFont(name: FontName.GradDuke, size: FontSize.button_18)
        self.btnTherapies.setTitle("T_PROFILE_THERAPIES".localized(), for: .normal)
        self.btnMassages.setFont(name: FontName.GradDuke, size: FontSize.button_18)
        self.btnMassages.setTitle("T_PROFILE_MASSAGE".localized(), for: .normal)
        self.btnMassages.setUnderlineTitle("T_PROFILE_MASSAGE".localized(), for: .normal)
        self.btnVerify.setTitle("BTN_APPLY".localized(), for: .normal)

        self.selectedMassages = selectedMassages
        self.selectedTherapies = selectedTherapies

        self.initialSetup()
        self.fillFiltered(normalArr: self.arrForMassages, selectedArray: self.selectedMassages)

    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.setCollectionView()
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

        if arrForMassages.isEmpty {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_ENTER_OTP".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedMassages, selectedTherapies);
            }
        }

    }


    @IBAction func btnMassageTapped(_ sender: Any) {
        self.btnMassages.setUnderlineTitle("T_PROFILE_MASSAGE".localized(), for: .normal)
        self.btnTherapies.resetNormalTitle("T_PROFILE_THERAPIES".localized(), for: .normal)
        self.isMassageSelected = true
        self.fillFiltered(normalArr: arrForMassages,selectedArray: self.selectedMassages)
    }
    
    @IBAction func btnTherapiesTapped(_ sender: Any) {
        self.btnMassages.resetNormalTitle("T_PROFILE_MASSAGE".localized(), for: .normal)
        self.btnTherapies.setUnderlineTitle("T_PROFILE_THERAPIES".localized(), for: .normal)
        self.isMassageSelected = false
        self.fillFiltered(normalArr: arrForTherapies,selectedArray: self.selectedTherapies)

    }

    func fillFiltered(normalArr: [WorkDetails], selectedArray:[WorkDetails]) {
        filteredArray.removeAll()
        for item in normalArr {
            var newItem: WorkDetails = item
            for therapi in selectedArray {
                    if item.id == therapi
                        .id {
                        newItem.isSelected = true
                    }
            }
            self.filteredArray.append(newItem)
        }
        collectionView.reloadData()
    }

   
    
}



//MARK:- Collection View Setup
extension TherapistWorkDialog : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.register(WorkCell.nib(), forCellWithReuseIdentifier: WorkCell.name)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        self.collectionView?.collectionViewLayout = layout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCell.name, for: indexPath) as! WorkCell
        cell.setData(self.filteredArray[indexPath.row], indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.filteredArray[indexPath.row].isSelected.toggle()

        if isMassageSelected {
            if let index = (selectedMassages.firstIndex { (item) -> Bool in
                item.id == self.filteredArray[indexPath.row].id
            }){
                selectedMassages.remove(at: index)
            } else {
                selectedMassages.append(self.filteredArray[indexPath.row])
            }
        } else {
            if let index = (selectedTherapies.firstIndex { (item) -> Bool in
                item.id == self.filteredArray[indexPath.row].id })
            {
                selectedTherapies.remove(at: index)
            }else {
                selectedTherapies.append(self.filteredArray[indexPath.row])
            }
        }
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing :CGFloat = 1.0
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 1.0
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        if let collection = self.collectionView {
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width )
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}

//MARK:   - Interative Animation
extension  TherapistWorkDialog {

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
