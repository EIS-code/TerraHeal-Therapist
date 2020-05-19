//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeView: UIView {
    
    override func draw(_ rect: CGRect) {
    }


}


//MARK: Underlined Button
class ThemeDialogView: ThemeView {
    var isCancellable:Bool = false
    var isAnimated:Bool = false
    deinit {
        print("\(self) \(#function)")
    }
}
