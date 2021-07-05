//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation


class TextFieldTableCell: TableCell {
    
    @IBOutlet weak var txtCellItem: ACFloatingTextfield!
    var formItem: FormItem?
    override func awakeFromNib()  {
        super.awakeFromNib()
        self.txtCellItem.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.formItem?.valueCompletion?(textField.text)
    }

    func setCellData(data: FormItem)  {
        self.formItem = data
        self.txtCellItem.setText(self.formItem?.value)
        self.txtCellItem.setPlaceholder(self.formItem?.placeholder)
        self.txtCellItem.configureTextFieldNative(data.uiProperties)
    }
}

