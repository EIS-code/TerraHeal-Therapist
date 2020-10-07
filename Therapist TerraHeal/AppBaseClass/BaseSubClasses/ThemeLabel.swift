//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


class ThemeLabel: UILabel {
    var previousFrame: CGRect?
    

    
    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper.fontCalculator(size: size)
        self.font = FontHelper.font(name: name, size: finalSize)
    }

    func animation(typing value:String,duration: Double){
        let characters = value.map { $0 }
        var index = 0
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true, block: { [weak self] timer in
            if index < value.count {
                let char = characters[index]
                self?.text! += "\(char)"
                index += 1
            } else {
                timer.invalidate()
            }
        })
    }


    func setTextWithAnimation(text:String,duration:CFTimeInterval = 0.3){
        fadeTransition(duration)
        self.setText(text)
    }

    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    func printFontSize() {
        print("\(self.text!) \n FontName: \(self.font.fontName) - FontSize: \(self.font.pointSize)")
    }
}


class ThemeVerticalAlignLabel: ThemeLabel {
    override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }
        let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 12)])
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }
        super.drawText(in: newRect)
    }
}
