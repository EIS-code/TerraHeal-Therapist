//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
open class ThemeTextField: UITextField {

    override open func draw(_ rect: CGRect) {
    }
    
    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.font = FontHelper.font(name: name, size: finalSize)
    }
}


open class ThemeTextView: UITextView {

    override open func draw(_ rect: CGRect) {
    }

    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.font = FontHelper.font(name: name, size: finalSize)
    }
}


extension UITextView {

    private class PlaceholderLabel: UILabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            label.textColor = UIColor.themePrimary
            addSubview(label)
            return label
        }
    }

    @IBInspectable
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)

            textStorage.delegate = self
        }
    }

}


extension UITextView: NSTextStorageDelegate{

    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
