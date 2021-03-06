//
//  UIImageCropper.swift
//  UIImageCropper
//
//  Created by Jari Kalinainen jari@klubitii.com
//
//  Licensed under MIT License 2017
//

import UIKit

@objc protocol UIImageCropperProtocol: class {
    /// Called when user presses crop button (or when there is unknown situation (one or both images will be nil)).
    /// - parameter originalImage
    ///   Orginal image from camera/gallery
    /// - parameter croppedImage
    ///   Cropped image in cropRatio aspect ratio
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?)
    /// (optional) Called when user cancels the picker. If method is not available picker is dismissed.
    @objc optional func didCancel()
}

class UIImageCropperVC: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var vwBg: UIView!
    /// Aspect ratio of the cropped image
    public var cropRatio: CGFloat = 1
    /// delegate that implements UIImageCropperProtocol
    public weak var delegate: UIImageCropperProtocol?
    /// UIImagePickerController picker
    public weak var picker: UIImagePickerController? {
        didSet {
            picker?.delegate = self
            picker?.allowsEditing = false
        }
    }

    @IBOutlet weak var btnRotate: FloatingRoundButton!
    @IBOutlet weak var btnCrop: FloatingRoundButton!
    @IBOutlet weak var btnCamera: FloatingRoundButton!
    /// Crop button text
    public var cropButtonText: String = "Crop"
    /// Retake/Cancel button text
    public var cancelButtonText: String = "Retake"

    /// original image from camera or gallery
    public var image: UIImage? {
        didSet {
            guard let image = self.image else {
                return
            }
            layoutDone = false
            if image.size.equalTo(CGSize.zero) {
                ratio = 1
            } else {
                ratio = image.size.height / image.size.width
            }

            self.view.layoutIfNeeded()
        }
    }
    /// cropped image
    public var cropImage: UIImage? {
        return crop()
    }

    /// autoClosePicker: if true, picker is dismissed when when image is cropped. When false parent needs to close picker.
    public var autoClosePicker: Bool = true
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var cropView: UIView!
    
    
    @IBOutlet weak var topConst: NSLayoutConstraint!
    @IBOutlet weak var leadConst: NSLayoutConstraint!
    @IBOutlet var imageHeightConst: NSLayoutConstraint!
    @IBOutlet var imageWidthConst: NSLayoutConstraint!
    
    

    private var ratio: CGFloat = 1
    private var layoutDone: Bool = false
    @IBOutlet weak var bottomView: UIStackView!
    
    private var orgHeight: CGFloat = 0
    private var orgWidth: CGFloat = 0
    private var topStart: CGFloat = 0
    private var leadStart: CGFloat = 0
    private var pinchStart: CGPoint = .zero
    
    //MARK: - inits
    /// initializer
    /// - parameter cropRatio
    /// Aspect ratio of the cropped image
    convenience public init(cropRatio: CGFloat) {
        self.init()
        self.cropRatio = cropRatio
    }

    //MARK: - overrides
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        vwBg.backgroundColor = UIColor.clear
        // image view
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageWidthConst = NSLayoutConstraint(item: imageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 1)
        imageWidthConst?.priority = .required
        imageHeightConst = NSLayoutConstraint(item: imageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1)
        imageHeightConst?.priority = .required
        imageView.addConstraints([imageHeightConst!, imageWidthConst!])
        imageView.image = self.image

        // imageView gestures
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        imageView.addGestureRecognizer(pinchGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        imageView.addGestureRecognizer(panGesture)
        imageView.isUserInteractionEnabled = true

        // crop overlay
        cropView.translatesAutoresizingMaskIntoConstraints = false
        cropView.isUserInteractionEnabled = false
        let ratioConst = NSLayoutConstraint(item: cropView ?? UIView(), attribute: .width, relatedBy: .equal, toItem: cropView, attribute: .height, multiplier: cropRatio, constant: 0)
        cropView.addConstraints([ratioConst])
        cropView.layer.borderWidth = 1
        cropView.layer.borderColor = UIColor.themePrimary.cgColor
        cropView.backgroundColor = UIColor.clear
        vwBg.layoutIfNeeded()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
    }
    @IBAction func btnRoateImage(_ sender: Any) {
        if let originalImage = self.imageView.image {
            self.imageView.image =  originalImage.rotate(radians: .pi/2)
            self.image = self.imageView.image
        }
    }
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !layoutDone else {
            return
        }
        layoutDone = true

        if ratio < 1 {
            imageWidthConst?.constant = cropView.frame.height / ratio
            imageHeightConst?.constant = cropView.frame.height
        } else {
            imageWidthConst?.constant = cropView.frame.width
            imageHeightConst?.constant = cropView.frame.width * ratio
        }
        DispatchQueue.main.async {
            /*self.cropView.superview!.setNeedsLayout()
            self.cropView.superview!.layoutIfNeeded()
            self.maskFadeView()*/
            
                      
        }
        orgWidth = imageWidthConst!.constant
        orgHeight = imageHeightConst!.constant
    }
    
    private func maskFadeView() {
        let path = UIBezierPath(rect: cropView.frame)
        path.append(UIBezierPath(rect: vwBg.bounds))
        let mask = CAShapeLayer()
        mask.fillRule = CAShapeLayerFillRule.evenOdd
        mask.path = path.cgPath
        fadeView.layer.mask = mask
    }

    //MARK: - button actions
    @objc func cropDone() {
        presenting = false
        if picker == nil {
            self.dismiss(animated: false, completion: {
                if self.autoClosePicker {
                    self.picker?.dismiss(animated: true, completion: nil)
                }
                self.delegate?.didCropImage(originalImage: self.image, croppedImage: self.cropImage)
            })
        } else {
            self.endAppearanceTransition()
            self.view.removeFromSuperview()
            self.removeFromParent()
            if self.autoClosePicker {
                self.picker?.dismiss(animated: true, completion: nil)
            }
            self.delegate?.didCropImage(originalImage: self.image, croppedImage: self.cropImage)
        }
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.cropCancel()
    }
    
    @IBAction func btnCropTapd(_ sender: Any) {
        self.cropDone()
    }
    
    @objc func cropCancel() {
        presenting = false
        if picker == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.endAppearanceTransition()
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
         self.delegate?.didCancel?()
    }

    //MARK: - gesture handling
    @objc func pinch(_ pinch: UIPinchGestureRecognizer) {
        if pinch.state == .began {
            orgWidth = imageWidthConst!.constant
            orgHeight = imageHeightConst!.constant
            pinchStart = pinch.location(in: self.view)
        }
        let scale = pinch.scale
        let height = max(orgHeight * scale, cropView.frame.height)
        let width = max(orgWidth * scale, cropView.frame.height / ratio)
        imageHeightConst?.constant = height
        imageWidthConst?.constant = width
    }
    
    @objc func pan(_ pan: UIPanGestureRecognizer) {
        if pan.state == .began {
            topStart = topConst!.constant
            leadStart = leadConst!.constant
        }
        let trans = pan.translation(in: self.view)
        leadConst?.constant = leadStart + trans.x
        topConst?.constant = topStart + trans.y
    }

    //MARK: - cropping done here
    private func crop() -> UIImage? {
        guard let image = self.image else {
            return nil
        }
        let imageSize = image.size
        let width = cropView.frame.width / imageView.frame.width
        let height = cropView.frame.height / imageView.frame.height
        let x = (cropView.frame.origin.x - imageView.frame.origin.x) / imageView.frame.width
        let y = (cropView.frame.origin.y - imageView.frame.origin.y) / imageView.frame.height

        let cropFrame = CGRect(x: x * imageSize.width, y: y * imageSize.height, width: imageSize.width * width, height: imageSize.height * height)
        if let cropCGImage = image.cgImage?.cropping(to: cropFrame) {
            let cropImage = UIImage(cgImage: cropCGImage, scale: 1, orientation: .up)
            return cropImage
        }
        return nil
    }

    //MARK: - UIImagePickerControllerDelegates
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        presenting = false
        if delegate?.didCancel?() == nil {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    var presenting = false
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard !presenting else {
            return
        }
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        layoutDone = false
        presenting = true
        self.image = image.fixOrientation()
        self.picker?.view.addSubview(self.view)
        self.view.constraintToFill(superView: self.picker?.view)
        self.picker?.addChild(self)
        self.willMove(toParent: self.picker)
        self.beginAppearanceTransition(true, animated: false)
    }
    
}

extension UIView {
    func constraintToFill(superView view: UIView?) {
        guard let view = view else {
            assertionFailure("superview is nil")
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}
