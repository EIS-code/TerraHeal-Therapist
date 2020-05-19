//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


class ThemeLabel: UILabel {

    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
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
        self.text = text
    }

    //followed from @Chris and @winnie-ru
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
