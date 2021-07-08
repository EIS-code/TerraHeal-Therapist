//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class CalendarGraphVC: BaseVC {
    
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var vwForCard: ThemeCardView!
    @IBOutlet weak var calendarWeekView: DefaultWeekView!
    @IBOutlet weak var bookingView: UIView!
    var bookingVC: MyBookingVC? = nil
    var arrForCalenderEvents:[DefaultEvent] = []
    var currentSelectedData: OptionsSelectedData! = OptionsSelectedData.init(viewType: .defaultView, date:Date(), numOfDays: 7, scrollType: .pageScroll, firstDayOfWeek: .Monday, hourGridDivision: .noneDiv, scrollableRange: (nil,nil) )
    var dateOfMonth: String = Date().startOfMonth().millisecondsSince1970.toString()
    @IBOutlet weak var scrView: UIScrollView!
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
        self.wsGetCalendarBooking()
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
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.vwForCard.topRound()
        self.vwForCard.backgroundColor = UIColor.themeWhite
        self.setupCalendarView()
    }

    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }
    // Support device orientation change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        JZWeekViewHelper.viewTransitionHandler(to: size, weekView: calendarWeekView)
    }

    private func setupCalendarView() {
        calendarWeekView.baseDelegate = self
        if self.currentSelectedData != nil {
            self.currentSelectedData.scrollableRange = (arrForCalenderEvents.first?.startDate, arrForCalenderEvents.last?.endDate)
            setupCalendarViewWithSelectedData()
            return
        }

        calendarWeekView.setupCalendar(numOfDays: 7,
                                       setDate: (arrForCalenderEvents.first?.startDate) ?? Date.init(),
                                       allEvents: JZWeekViewHelper.getIntraEventsByDate(originalEvents: arrForCalenderEvents),
                                       scrollType: .pageScroll)
        calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: JZHourGridDivision.noneDiv))
    }

    /// For example only
    private func setupCalendarViewWithSelectedData() {

        guard let selectedData = self.currentSelectedData else { return }
        let eventForCal = JZWeekViewHelper.getIntraEventsByDate(originalEvents: arrForCalenderEvents)
        calendarWeekView.setupCalendar(numOfDays: selectedData.numOfDays,
                                       setDate: selectedData.date,
                                       allEvents: eventForCal,
                                       scrollType: selectedData.scrollType,
                                       firstDayOfWeek: selectedData.firstDayOfWeek)
        calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: selectedData.hourGridDivision))
    }

    func viewBookingSelected(date:String) {
        if bookingVC == nil {
            bookingVC = MyBookingVC.fromNib()
        }
        bookingVC?.wsGetBookingList(date: date)
        self.add(bookingVC!, view:self.bookingView)
        self.scrView.visible()
        //self.calendarWeekView.gone()
    }
}

extension CalendarGraphVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
            if (actualPosition.y > 40){
                self.scrView.gone()
                // Dragging down
            }else{
                // Dragging up
            }
    }
}

extension CalendarGraphVC: JZBaseViewDelegate {
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        updateNaviBarTitle()
    }
    func eventClicked(_ event: JZBaseEvent) {
        self.viewBookingSelected(date: event.startDate.millisecondsSince1970.toString())
    }


}


// For example only
extension CalendarGraphVC {

    func wsGetCalendarBooking() {
        CalenderWebService.callCalenderEvents(params: CalenderWebService.RequestGetCalender.init(date: self.dateOfMonth), completionHandler: { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForCalenderEvents.removeAll()
                for i in 0..<response.bookingList.count {
                    let data = response.bookingList[i]
                    let newDate = Date.init(milliseconds: data.massageDate.toDouble)
                    let newStartDate = Date.init(milliseconds: data.massageDate.toDouble)
                    if newStartDate.millisecondsSince1970 > 0 {
                        self.arrForCalenderEvents.append(DefaultEvent.init(id: data.bookingInfoId, title: data.bookingInfoId, startDate: newStartDate, endDate: newStartDate.add(component: .minute, value: data.time.toInt)))
                    }
                }
                if let selectedDate = self.arrForCalenderEvents.last?.startDate {
                    self.currentSelectedData.date = selectedDate
                }
                self.setupCalendarView()
                self.calendarWeekView.scrollWeekView(to: self.currentSelectedData.date)
            }

        })


    }

    private func updateNaviBarTitle() {
        let dateForMonth = calendarWeekView.initDate.add(component: .day, value: calendarWeekView.numOfDays)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        let month = dateFormatter.string(from:dateForMonth )
        self.btnMonth.setText(month)
        let newDateOFMonth = dateForMonth.startOfMonth().millisecondsSince1970.toString()
        if newDateOFMonth != self.dateOfMonth {
            self.dateOfMonth = newDateOFMonth
            self.wsGetCalendarBooking()
        }
    }
}
