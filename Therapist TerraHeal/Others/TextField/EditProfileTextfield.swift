//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//


import UIKit

@IBDesignable
@objc open class EditProfileTextfield: ThemeTextField {
    
    fileprivate var bottomLineView : UIView?
    fileprivate var labelPlaceholder : ThemeLabel?
    fileprivate var bottomLineViewHeight : NSLayoutConstraint?
    fileprivate var placeholderLabelHeight : NSLayoutConstraint?
    fileprivate var placeholderLabelLeading : NSLayoutConstraint?

    var leftImage: UIImage? = UIImage()
    let rightButton  = UIButton(type: .custom)

    @IBInspectable open var disableFloatingLabel : Bool = false
    @IBInspectable open var lineColor : UIColor = UIColor.themeLightTextColor {
        didSet{
            self.floatTheLabel()
        }
    }

    @IBInspectable open var textForeColor : UIColor = UIColor.themeLightTextColor {
        didSet{
            self.floatTheLabel()
        }
    }
    @IBInspectable open var leftViewColor : UIColor = UIColor.themePrimary {
        didSet{
            self.floatTheLabel()
        }
    }

    @IBInspectable open var selectedLineColor : UIColor = UIColor.themeLightTextColor{
        didSet{
            self.floatTheLabel()
        }
    }
    
    @IBInspectable open var placeHolderColor : UIColor = UIColor.themeLightTextColor {
        didSet{
            self.floatTheLabel()
        }
    }
    
    @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor.themeLightTextColor {
        didSet{
            self.floatTheLabel()
        }
    }

    override open var text:String?  {
        didSet {
            floatTheLabel()
        }
    }
    
    override open var placeholder: String? {
        willSet {
            if newValue != "" {
                self.labelPlaceholder?.text = newValue
            }
        }
    }

    //MARK:- UITtextfield Draw Method Override
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        self.initialize()
    }
    
    // MARK:- Loading From NIB
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    // MARK:- Intialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }

    func upadteTextField(frame:CGRect) -> Void {
        self.frame = frame;
        self.initialize()
    }

    // MARK:- Text Rect Management
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 0
        
        return CGRect(x:textRect.width, y: JDDeviceHelper.offseter(offset: 15), width:bounds.size.width, height:bounds.size.height);
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 0

        return CGRect(x:textRect.width, y: JDDeviceHelper.offseter(offset: 15), width:bounds.size.width, height:bounds.size.height);
    }

    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 0
        return textRect
    }

    //MARK:- UITextfield Becomes First Responder
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.textFieldDidBeginEditing()
        return result
    }
    
    //MARK:- UITextfield Resigns Responder
    override open func resignFirstResponder() -> Bool {
        let result =  super.resignFirstResponder()
        self.textFieldDidEndEditing()
        return result
    }

    //MARK:- UITextField Begin Editing.
    func textFieldDidBeginEditing() -> Void {

        if !self.disableFloatingLabel {
            self.placeholder = ""
        }
        self.floatTheLabel()
        self.layoutSubviews()
    }

    //MARK:- UITextField Begin Editing.
    func textFieldDidEndEditing() -> Void {
        self.floatTheLabel()
    }

    func getPaddingHeight() -> CGFloat {
        return  self.bounds.height
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if placeholderLabelLeading?.constant != self.getPaddingHeight() {
            placeholderLabelLeading?.constant = self.getPaddingHeight()
        }
   }
}

//MARK: Custom Methods
extension EditProfileTextfield {
    
    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        self.clipsToBounds = true
        
        self.addLeftView()
        self.textColor = textForeColor
        self.setFont(name:FontName.Regular,size:FontSize.textField_14)
        addBottomLine()
        addFloatingLabel()
        self.contentVerticalAlignment =  .top
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        addTarget(self, action: #selector(fix), for: .editingChanged)
    }

    func addBottomLine(){
        if bottomLineView?.superview != nil {
            return
        }
        bottomLineView = UIView()
        bottomLineView?.backgroundColor = lineColor
        bottomLineView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLineView!)
        let leadingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        bottomLineViewHeight = NSLayoutConstraint.init(item: bottomLineView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        self.addConstraints([leadingConstraint,trailingConstraint,bottomConstraint])
        bottomLineView?.addConstraint(bottomLineViewHeight!)
        self.addTarget(self, action: #selector(self.textfieldEditingChanged), for: .editingChanged)
    }
    
    @objc func textfieldEditingChanged(){

    }

}
//MARK: Placeholder Settelment
extension EditProfileTextfield {

    //MARK:- ADD Floating Label
    func addFloatingLabel(){

        if labelPlaceholder?.superview != nil {
            return
        }
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        labelPlaceholder = ThemeLabel()
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.setFont(name: FontName.SemiBold, size: FontSize.placeHolder_14)
        labelPlaceholder?.isHidden = true
        labelPlaceholder?.sizeToFit()
        labelPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        self.changePlaceHolder(color: placeHolderColor)
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }

        placeholderLabelLeading = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: self.getPaddingHeight())

        let trailingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        placeholderLabelHeight = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: JDDeviceHelper.offseter(offset: 15))
        self.addConstraints([placeholderLabelLeading!,trailingConstraint,topConstraint])
        labelPlaceholder?.addConstraint(placeholderLabelHeight!)
    }
    //MARK:- Float & Resign
    func floatTheLabel() -> Void {
        DispatchQueue.main.async {
            if self.text == "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }else if self.text == "" && !self.isFirstResponder {
                self.resignPlaceholder()
            }else if self.text != "" && !self.isFirstResponder  {
                self.floatPlaceHolder(selected: false)
            }else if self.text != "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }
        }
    }
    //MARK:- Float UITextfield Placeholder Label
    func floatPlaceHolder(selected:Bool) -> Void {
        labelPlaceholder?.isHidden = false
        if selected {
            bottomLineView?.backgroundColor = self.selectedLineColor;
            labelPlaceholder?.textColor = self.selectedPlaceHolderColor;
            bottomLineViewHeight?.constant = 2;
            self.changePlaceHolder(color: self.selectedPlaceHolderColor)
        } else {
            bottomLineView?.backgroundColor =  self.lineColor;
            bottomLineViewHeight?.constant = 1;
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.changePlaceHolder(color: self.placeHolderColor)
        }

        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            return
        }

        if placeholderLabelHeight?.constant == JDDeviceHelper.offseter(offset: 15)
        {
            return
        }
        placeholderLabelHeight?.constant = JDDeviceHelper.offseter(offset: 15);
        labelPlaceholder?.setFont(name: FontName.Regular, size: FontSize.placeHolder_14)
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {
        self.changePlaceHolder(color: self.placeHolderColor)
        bottomLineView?.backgroundColor = self.lineColor;
        bottomLineViewHeight?.constant = 1;
        if disableFloatingLabel {
            labelPlaceholder?.isHidden = true
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
            return
        }
        placeholderLabelHeight?.constant = self.frame.height
        UIView.animate(withDuration: 0.3, animations: {
            self.labelPlaceholder?.font = self.font
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.layoutIfNeeded()
        }) { (finished) in
            self.labelPlaceholder?.isHidden = true
            self.placeholder = self.labelPlaceholder?.text
        }
    }

   
}


//MARK: RightView Settelment
extension EditProfileTextfield {

    func setupPasswordTextFielad() {
        self.rightButton.setImage(UIImage(named: "asset-password-show") , for: .normal)
        self.rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        self.rightButton.frame = CGRect(x:0, y:0, width:30, height:30)
        self.rightViewMode = .always
        self.rightView = rightButton
        self.isSecureTextEntry = true
    }
    @objc func toggleShowHide(button: UIButton) {
        togglePasswordVisibility()
    }

    func togglePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        if let textRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument) {
            self.replace(textRange, withText: self.text!)
        }
        if isSecureTextEntry {
            rightButton.setImage(UIImage(named: "asset-password-show") , for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "asset-password-hide") , for: .normal)
        }
    }

}
//MARK: Leftview Settelment
extension EditProfileTextfield {
    func addLeftView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always

            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.getPaddingHeight(), height: self.getPaddingHeight()))
            paddingView.backgroundColor = .clear
            
            
            
            let vwImageBg : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.getPaddingHeight() * 0.7, height: self.getPaddingHeight() * 0.7))
        
            vwImageBg.backgroundColor = self.leftViewColor
            
            let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width:  self.getPaddingHeight() * 0.4, height:  self.getPaddingHeight() * 0.5))
            imageView.center = vwImageBg.center
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            vwImageBg.addSubview(imageView)
            vwImageBg.setRound()
            vwImageBg.center = paddingView.center
            paddingView.addSubview(vwImageBg)
            leftView = paddingView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
}



