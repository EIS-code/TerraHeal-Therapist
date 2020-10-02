//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

//MARK: Checkbox Button
@IBDesignable
public class JDCheckboxButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImages()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setImages()
    }
    
    let checkedImage = UIImage(named: "asset-checked")
    let uncheckedImage = UIImage(named: "asset-unchecked")
    
    func setImages() {
        self.setImage(uncheckedImage, for: .normal)
        self.setImage(checkedImage, for: .selected)
    }
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
