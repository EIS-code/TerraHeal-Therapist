//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

struct FontName {
    static let SemiBold: String = "Nunito-SemiBold"
    static let Regular: String = "Nunito-Regular"
    static let Bold: String = "Nunito-Bold"
    static let System: String = ""
}

struct FontSize {
    static let nav_title_18: CGFloat = 18
    static let textField_14: CGFloat = 14
    static let placeHolder_14: CGFloat = 12
    static let textField_regular: CGFloat = 21
    //Label Fonts
    static let doubleExLarge: CGFloat = 38
    static let exLarge: CGFloat = 34
    static let large: CGFloat = 27
    static let header: CGFloat = 21
    static let subHeader: CGFloat = 17
    static let regular: CGFloat = 14
    static let detail: CGFloat = 13
    static let small: CGFloat = 10
    //Button Fonts
    static let proceedButton: CGFloat = 14
    static let button_14: CGFloat = 14
    static let button_17: CGFloat = 17
    static let button_13: CGFloat = 13
    static let button_20: CGFloat = 20
    static let button_21: CGFloat = 21
    static let button_22: CGFloat = 22
}

class FontHelper: UIFont {
    class func font(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name , size: size) ?? UIFont.systemFont(ofSize: size)
    }

}

struct FontSymbol {
    static let next_arrow = "❯"
    static let back_arrow = "❮"
    static let down_arrow = ""
    static let up_arrow = "❮"
    static let check = "✓"
    static let cancel = "✕"
}
