import Foundation
//MARK: Web Service Calls
extension BookingWebSerive {
    class func todayBookingList(params:BookingWebSerive.RequestTodayBookingList = BookingWebSerive.RequestTodayBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.TodayBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func pastBookingList(params:BookingWebSerive.RequestPastBookingList = BookingWebSerive.RequestPastBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PastBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func futureBookingList(params:BookingWebSerive.RequestFutureBookingList = BookingWebSerive.RequestFutureBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.FutureBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getBookingDetail(params:BookingWebSerive.RequestBookingDetail = BookingWebSerive.RequestBookingDetail.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingDetail) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.BookingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getBookingDetailByDate(params:BookingWebSerive.RequestBookingDetail = BookingWebSerive.RequestBookingDetail.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingDetail) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.BookingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func startMassageService(params:BookingWebSerive.RequestStartService, completionHandler: @escaping ((BookingWebSerive.ResponseBookingDetail) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: BookingWebSerive.startSevice, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func finishMassageService(params:BookingWebSerive.RequestEndService, completionHandler: @escaping ((BookingWebSerive.ResponseBookingDetail) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: BookingWebSerive.startSevice, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
