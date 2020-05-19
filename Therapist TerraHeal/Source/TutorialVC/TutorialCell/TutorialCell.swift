//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation


struct TutorialDetail {
    var title:String = ""
    var description:String = ""
}

class TutorialCell: CollectionCell {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(tutorialDetail:TutorialDetail) {
        self.lblTitle?.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblDescription?.setFont(name: FontName.Ovo, size: FontSize.label_18)
        self.lblTitle?.text = tutorialDetail.title
        self.lblDescription?.text = tutorialDetail.description
    }
}




