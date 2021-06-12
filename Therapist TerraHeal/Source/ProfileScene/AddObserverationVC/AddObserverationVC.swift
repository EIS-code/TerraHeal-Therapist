//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class AddObserverationVC: BaseVC {


    @IBOutlet weak var tvForObservation: ThemeTextView!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var btnSkip: ThemeButton!
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {

        }
    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    private func initialViewSetup() {
        self.setNavigationTitle(title: "ADD_OBSERVATION_TITLE".localized())
        self.setBackground(color: UIColor.themeLightBackground)

    }
   
    @IBAction func btnDoneTapped(_ sender: Any) {

    }
    @IBAction func btnSkipTapped(_ sender: Any) {

    }

}


