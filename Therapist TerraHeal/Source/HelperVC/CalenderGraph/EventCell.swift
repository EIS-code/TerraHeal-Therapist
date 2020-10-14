//
//  EventCell.swift
//  timegenii
//
//  Created by Jeff Zhang on 14/9/17.
//  Copyright © 2017 unimelb. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {


    @IBOutlet weak var borderView: UIView!
    var event: DefaultEvent!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupBasic()
    }

    func setupBasic() {
        self.clipsToBounds = true
        borderView.backgroundColor = UIColor.themeSecondary

    }

    func configureCell(event: DefaultEvent) {
        self.event = event
    }

}
