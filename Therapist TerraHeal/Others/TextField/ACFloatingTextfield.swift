//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//


import UIKit



@IBDesignable
@objc open class ACFloatingTextfield: ThemeTextField {
    
    fileprivate var bottomLineView : UIView?
    fileprivate var labelPlaceholder : UILabel?
    fileprivate var labelErrorPlaceholder : UILabel?
    fileprivate var showingError : Bool = false
    fileprivate var bottomLineViewHeight : NSLayoutConstraint?
    fileprivate var placeholderLabelHeight : NSLayoutConstraint?
    fileprivate var errorLabelHieght : NSLayoutConstraint?
    var inputConfiguration: InputTextFieldDetail = InputTextFieldDetail.init()
    let rightButton  = UIButton(type: .custom)
    @IBInspectable open var disableFloatingLabel : Bool = false
    @IBInspectable open var shakeLineWithError : Bool = true
    @IBInspectable open var lineColor : UIColor = UIColor.themeHintText {
        didSet{
            self.floatTheLabel()
        }
    }
    @IBInspectable open var selectedLineColor : UIColor = UIColor.themeDarkText{
        didSet{
            self.floatTheLabel()
        }
    }
    
    @IBInspectable open var placeHolderColor : UIColor = UIColor.themeHintText {
        didSet{
            self.floatTheLabel()
        }
    }
    
    @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor.themeDarkText {
        didSet{
            self.floatTheLabel()
        }
    }
    
    @IBInspectable open var errorTextColor : UIColor = UIColor.red{
        didSet{
            self.labelErrorPlaceholder?.textColor = errorTextColor
            self.floatTheLabel()
        }
    }
    
    @IBInspectable open var errorLineColor : UIColor = UIColor.red{
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
    
    open var errorText : String? {
        willSet {
            self.labelErrorPlaceholder?.text = newValue
        }
    }
    
    //MARK:- UITtextfield Draw Method Override
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        //self.upadteTextField(frame: CGRect(x:self.frame.minX, y:self.frame.minY, width:rect.width, height:rect.height));
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
    
    // MARK:- Text Rect Management
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:0, y:4, width:bounds.size.width, height:bounds.size.height);
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:0, y:4, width:bounds.size.width, height:bounds.size.height);
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
    
   public func setupPasswordTextFielad() {

        self.rightButton.setImage(UIImage(named: "asset-password-show") , for: .normal)
        self.rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        self.rightButton.frame = CGRect(x:0, y:0, width:30, height:30)

        self.rightViewMode = .always
        self.rightView = rightButton
        self.isSecureTextEntry = true

    }
    public func configureTextField(_ configuration: InputTextFieldDetail) {
            self.inputConfiguration = configuration
           self.maxLength = self.inputConfiguration.maxLength
           self.textContentType = self.inputConfiguration.textContentType
           self.keyboardType = self.inputConfiguration.keyBoardType
    }
    public func validate() -> (isValid: Bool, message: String) {
           if !self.inputConfiguration.isMadatory {
               return (true,"")
           } else {
            
            var textDetial = ""
            if  let placeholderDetail = self.placeholder, !placeholderDetail.isEmpty() {
                textDetial = placeholderDetail
            } else {
                textDetial = self.labelPlaceholder?.text ?? ""
            }
            if self.text!.isEmpty() {
                return(false,"Please enter \(textDetial) details")
            } else {
                if self.inputConfiguration.minLength == 0 && self.inputConfiguration.maxLength == 0 {
                    
                }
                else if self.text!.count < self.inputConfiguration.minLength || self.text!.count > self.inputConfiguration.maxLength {
                        return(false,"\(textDetial) detail length should be between \(self.inputConfiguration.minLength) - \(self.inputConfiguration.maxLength) ")
                }
                   switch self.inputConfiguration.texFieldType {
                   case .Name:
                    return(true,"VALIDATION_MSG_INVALID_NAME".localized())
                   case .Password:
                    return(self.text!.isValidPassword,"VALIDATION_MSG_INVALID_PASSWORD".localized())
                   case .Surname:
                    return(true,"VALIDATION_MSG_INVALID_SURNAME".localized())
                   case .Gender:
                    return(true,"VALIDATION_MSG_INVALID_GENDER".localized())
                   case .DOB:
                    return(true,"VALIDATION_MSG_INVALID_DOB".localized())
                   case .Phone:
                    return(self.text!.isPhoneNumber,"VALIDATION_MSG_INVALID_MOBILE".localized())
                   case .EmergencyContact:
                       return(self.text!.isPhoneNumber,"VALIDATION_MSG_INVALID_MOBILE".localized())
                   case .Email:
                    return(self.text!.isValidEmail(),"VALIDATION_MSG_INVALID_EMAIL".localized())
                   case .City:
                       return(true,"VALIDATION_MSG_INVALID_CITY".localized())
                   case .Country:
                       return(true,"VALIDATION_MSG_INVALID_COUNTRY".localized())
                   case .Nif:
                       return(true,"VALIDATION_MSG_INVALID_NIF".localized())
                   case .IdPassport:
                       return(true,"VALIDATION_MSG_INVALID_ID".localized())
                   case .Number:
                       return(self.text!.isNumber(),"VALIDATION_MSG_NUMBER_ONLY".localized())
                   case .Default:
                       return(true,"")
                   }
                       
               }
               
           }
       }
}

fileprivate extension ACFloatingTextfield {
    
    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        self.clipsToBounds = true
        self.textColor = UIColor.themeDarkText
        self.autocorrectionType = .no
        self.setFont(name:FontName.Regular,size:FontSize.textField_20)
        addBottomLine()
        addFloatingLabel()
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        addTarget(self, action: #selector(fix), for: .editingChanged)
    }
    
    //MARK:- ADD Bottom Line
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
    
    //MARK:- ADD Floating Label
    func addFloatingLabel(){

        if labelPlaceholder?.superview != nil {
            return
        }
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        labelPlaceholder = UILabel()
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = UIFont.init(name: (self.font?.fontName ?? "helvetica")!, size: JDDeviceHelper().fontCalculator(size: 12))
        labelPlaceholder?.isHidden = true
        labelPlaceholder?.sizeToFit()
        labelPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        self.changePlaceHolder(color: placeHolderColor)
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
        let leadingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        placeholderLabelHeight = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: JDDeviceHelper().offseter(offset: 15, direction: .horizontal, currentDeviceBound: 375))
        self.addConstraints([leadingConstraint,trailingConstraint,topConstraint])
        labelPlaceholder?.addConstraint(placeholderLabelHeight!)
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
            
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.selectedLineColor;
            labelPlaceholder?.textColor = self.selectedPlaceHolderColor;
            bottomLineViewHeight?.constant = 2;
            self.changePlaceHolder(color: self.selectedPlaceHolderColor)
            
        } else {
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
            bottomLineViewHeight?.constant = 1;
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.changePlaceHolder(color: self.placeHolderColor)
        }
        
        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            return
        }
        
        if placeholderLabelHeight?.constant == JDDeviceHelper().offseter(offset: 15, direction: .horizontal, currentDeviceBound: 375) {
            return
        }
        
        placeholderLabelHeight?.constant = JDDeviceHelper().offseter(offset: 15, direction: .horizontal, currentDeviceBound: 375);
        labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: JDDeviceHelper().fontCalculator(size: 12))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
        
    }
    
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {
        
        self.changePlaceHolder(color: self.placeHolderColor)
        
        bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
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
   
    
   
}




