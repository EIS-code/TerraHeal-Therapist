//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
import WebKit
class UploadedDocumentTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var btnDelete: FloatingRoundButton!
    @IBOutlet weak var wkWebView: WKWebView!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.header)
        self.btnDelete?.setRound()
    }

    func setData(data: UploadDocumentDetail ) {
        self.lblName.text = data.name
        if let url = data.url {
            self.wkWebView.load(URLRequest.init(url: URL.init(string: url)!))
            self.wkWebView.backgroundColor = .clear
            self.wkWebView.scrollView.backgroundColor = .clear
            self.wkWebView.isOpaque = false;
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDelete?.setRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
