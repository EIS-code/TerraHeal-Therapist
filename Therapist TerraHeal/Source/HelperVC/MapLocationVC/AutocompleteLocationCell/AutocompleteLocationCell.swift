//  
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class AutocompleteLocationCell: TableCell
{
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblSubTitle: ThemeLabel!
    @IBOutlet weak var viewForAutocomplete: UIView!
    @IBOutlet weak var vwDivider: UIView!
    
    //MARK:- LIFECYCLE
    override func awakeFromNib()
    {
        super.awakeFromNib()
        setLocalization()
        
    }
    //MARK:- SET CELL DATA
    func setCellData(place:AutoCompleteAddress)
    {
        lblTitle.attributedText = place.title
        lblSubTitle.attributedText = place.subTitle
    }
    func setLocalization()
    {
        //Colors
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        viewForAutocomplete.backgroundColor = UIColor.white
        vwDivider.backgroundColor = UIColor.themePrimary
        
        lblTitle.textColor = UIColor.themePrimary
        lblSubTitle.textColor = UIColor.themePrimaryLight
        /*Set Font*/
        lblTitle.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        lblSubTitle.setFont(name: FontName.Regular, size: FontSize.label_10)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    
}




