//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
// import JDFramework

class MainVC: UIViewController {
   
    @IBOutlet weak var vwBar: UIView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var btnLeft: UIButton?
    @IBOutlet weak var btnRight: UIButton?
    
    // MARK: - LifeCycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwBar?.backgroundColor = UIColor.clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - StatusBar
    deinit {
        print("\(self) \(#function)")
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    // MARK: - IBAction
    @IBAction func btnLeftTapped(_ btn: UIButton = UIButton()) {
    }
    
    @IBAction func btnRightTapped(_ btn: UIButton = UIButton()) {
    }

    func setTitle(title: String) {
        lblTitle?.text = title
    }
  
 }






class CollectionCell: UICollectionViewCell {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

class TableCell: UITableViewCell {

}
