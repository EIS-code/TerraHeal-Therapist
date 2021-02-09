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
    var currentSelectedData: OptionsSelectedData! = OptionsSelectedData.init(viewType: .defaultView, date:Date.init(milliseconds: 1599567170000), numOfDays: 7, scrollType: .pageScroll, firstDayOfWeek: .Monday, hourGridDivision: .noneDiv, scrollableRange: (nil,nil) )

    @IBOutlet weak var scrView: UIScrollView!
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
        self.wsGetTodaysBooking()
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

        // For example only
        if self.currentSelectedData != nil {
            setupCalendarViewWithSelectedData()
            return
        }
        // Basic setup
        calendarWeekView.setupCalendar(numOfDays: 7,
                                       setDate: Date(),
                                       allEvents: JZWeekViewHelper.getIntraEventsByDate(originalEvents: arrForCalenderEvents),
                                       scrollType: .pageScroll)
        // Optional
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

    func viewBookingSelected() {
        if bookingVC == nil {
            bookingVC = MyBookingVC.fromNib()
        }
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
        print((event as! DefaultEvent).title)
        self.viewBookingSelected()
    }


}


// For example only
extension CalendarGraphVC {

    func wsGetTodaysBooking() {
        BookingWebSerive.todayBookingList { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForCalenderEvents.removeAll()
                for i in 0..<response.bookingList.count {
                    let data = response.bookingList[i]
                    let newStartDate = Date.init(milliseconds: data.bookingDateTime.toDouble).add(component: .day, value: i).add(component: .hour, value: i)
                    self.arrForCalenderEvents.append(DefaultEvent.init(id: data.bookingInfoId, title: data.bookingInfoId, startDate: newStartDate, endDate: newStartDate.add(component: .minute, value: 15)))
                }
                if let selectedDate = self.arrForCalenderEvents.first?.startDate {
                    self.currentSelectedData.date = selectedDate
                }

                self.setupCalendarView()
                //self.calendarWeekView.collectionView.reloadData()

            }
        }
    }

    func setupBasic() {
        // Add this to fix lower than iOS11 problems

    }
    private func updateNaviBarTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        let month = dateFormatter.string(from: calendarWeekView.initDate.add(component: .day, value: calendarWeekView.numOfDays))
        self.btnMonth.setText(month)

    }
}
