//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class DatePickerTableCell: SelectionBorderTableCell {

    @IBOutlet weak var timePicker2: UIDatePicker!
    @IBOutlet weak var timePicker1: UIDatePicker!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTimer()
    }
    func setupTimer() {
        timePicker1.maximumDate = timePicker2.minimumDate
    }

    @IBAction func time2Changed(_ sender: Any) {
        timePicker1.maximumDate = timePicker2.minimumDate
    }
    @IBAction func time1Changed(_ sender: Any) {
        timePicker2.minimumDate = timePicker1.maximumDate
    }

    override func layoutSubviews() {
        super.layoutSubviews()
       // self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
