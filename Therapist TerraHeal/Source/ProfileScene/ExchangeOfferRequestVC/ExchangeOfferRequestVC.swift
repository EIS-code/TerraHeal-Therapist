//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class ExchangeOfferRequestVC: BaseVC {

   @IBOutlet weak var tblVwForData: UITableView!
    var arrForData:[ExchangeShiftData] = []
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
        self.wsGetExchangeRequestList()
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
            self.tblVwForData.reloadData()
        }
    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    private func initialViewSetup() {
        self.setNavigationTitle(title: "EXCHANGE_OFFER_REQUEST_TITLE".localized())
        self.setBackground(color: UIColor.themeLightBackground)
        self.setupTableView(tableView: self.tblVwForData)
    }
   

}




extension ExchangeOfferRequestVC {
    func wsGetExchangeRequestList() {
        Loader.showLoading()
        ExchangeWithOtherWebService.requestToGetExchangeOffers { response in
            Loader.hideLoading()
            self.arrForData.removeAll()
            for data in response.data {
                self.arrForData.append(data)
            }
            self.tblVwForData.reloadData()
        }
    }

    func wsAcceptRequest(id:String) {
        Loader.showLoading()
        ExchangeWithOtherWebService.requestToAcceptExchangeOffer(params: ExchangeWithOtherWebService.RequestToChangeStatus.init(exchange_shift_id: id)) { response in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {

            }
        }
    }

    func wsRejectRequest(id:String) {
        Loader.showLoading()
        ExchangeWithOtherWebService.requestToRejectExchangeOffer(params: ExchangeWithOtherWebService.RequestToChangeStatus.init(exchange_shift_id: id)) { response in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {

            }
        }
    }
}
