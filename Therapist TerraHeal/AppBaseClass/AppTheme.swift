//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {

    //Custom TextFieldColors
    static var themePrimary:UIColor = UIColor.init(named: "theme_primary") ?? UIColor.init(hex: "#9A4026")
    static var themePrimaryLight:UIColor = UIColor.init(named: "theme_primary_light") ?? UIColor.init(hex: "#000000")
    static var themePrimaryBorder:UIColor = UIColor.init(named: "theme_primary_border") ?? UIColor.init(hex: "#000000")
    static var themePrimaryLightBackground:UIColor = UIColor.init(named: "theme_primary_light_background") ?? UIColor.init(hex: "#000000")


}

//MARK: Color Extension
extension UIColor {

    public convenience init(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255.0
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255.0
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255.0
                    a = CGFloat(hexNumber & 0x000000ff) / 255.0

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
            else if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x000000ff) / 255.0

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
        return
    }

}
