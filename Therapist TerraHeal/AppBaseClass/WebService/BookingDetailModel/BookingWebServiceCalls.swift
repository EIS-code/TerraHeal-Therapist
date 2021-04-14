import Foundation
//MARK: Web Service Calls
extension BookingWebSerive {

    class func myBookingPendingList(completionHandler: @escaping ((BookingWebSerive.ResponseMyBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.bookingListPendingURL, methodName: AlamofireHelper.POST_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseMyBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func myBookingUpcomingList(completionHandler: @escaping ((BookingWebSerive.ResponseMyBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.bookingListUpcomingURL, methodName: AlamofireHelper.POST_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseMyBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func myBookingPastList(completionHandler: @escaping ((BookingWebSerive.ResponseMyBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.bookingListPastURL, methodName: AlamofireHelper.POST_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseMyBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func todayBookingList(params:BookingWebSerive.RequestBookingList, completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.TodayBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func numberOfBookingList(completionHandler: @escaping ((BookingWebSerive.ResponseMyBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.allBookingListURL, methodName: AlamofireHelper.POST_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseMyBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func pastBookingList(params:BookingWebSerive.RequestBookingList, completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PastBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func futureBookingList(params:BookingWebSerive.RequestBookingList, completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
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
        AlamofireHelper().getDataFrom(urlString: BookingWebSerive.endService, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

}
