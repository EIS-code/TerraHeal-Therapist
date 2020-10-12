//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class CalendarGraphVC: BaseVC {
    
    @IBOutlet weak var vwForCard: ThemeCardView!
    @IBOutlet weak var calendarWeekView: DefaultWeekView!
    let viewModel = DefaultViewModel()
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
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.vwForCard.topRound()
        self.vwForCard.backgroundColor = UIColor.themeWhite
        self.automaticallyAdjustsScrollViewInsets = false
        self.setupCalendarView()
    }

    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
     // Support device orientation change
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            JZWeekViewHelper.viewTransitionHandler(to: size, weekView: calendarWeekView)
        }

        private func setupCalendarView() {
            calendarWeekView.baseDelegate = self

            // For example only
            if viewModel.currentSelectedData != nil {
                setupCalendarViewWithSelectedData()
                return
            }
            // Basic setup
            calendarWeekView.setupCalendar(numOfDays: 7,
                                           setDate: Date(),
                                           allEvents: viewModel.eventsByDate,
                                           scrollType: .pageScroll)
            // Optional
            calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: JZHourGridDivision.noneDiv))
        }

        /// For example only
        private func setupCalendarViewWithSelectedData() {/*
            guard let selectedData = viewModel.currentSelectedData else { return }
            calendarWeekView.setupCalendar(numOfDays: selectedData.numOfDays,
                                           setDate: selectedData.date,
                                           allEvents: viewModel.eventsByDate,
                                           scrollType: selectedData.scrollType,
                                           firstDayOfWeek: selectedData.firstDayOfWeek)
            calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: selectedData.hourGridDivision))*/
        }
    }


extension CalendarGraphVC: JZBaseViewDelegate {
        func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
            updateNaviBarTitle()
        }
}


// For example only
extension CalendarGraphVC {

        func setupBasic() {
            // Add this to fix lower than iOS11 problems

        }

        private func setupNaviBar() {
            updateNaviBarTitle()
        }

        private func getSelectedData() -> OptionsSelectedData {
            let numOfDays = calendarWeekView.numOfDays!
            let firstDayOfWeek = numOfDays == 7 ? calendarWeekView.firstDayOfWeek : nil
            viewModel.currentSelectedData = OptionsSelectedData(viewType: .defaultView,
                                                                date: calendarWeekView.initDate.add(component: .day, value: numOfDays),
                                                                numOfDays: numOfDays,
                                                                scrollType: calendarWeekView.scrollType,
                                                                firstDayOfWeek: firstDayOfWeek,
                                                                hourGridDivision: calendarWeekView.flowLayout.hourGridDivision,
                                                                scrollableRange: calendarWeekView.scrollableRange)
            return viewModel.currentSelectedData
        }

        func finishUpdate(selectedData: OptionsSelectedData) {

            // Update numOfDays
            if selectedData.numOfDays != viewModel.currentSelectedData.numOfDays {
                calendarWeekView.numOfDays = selectedData.numOfDays
                calendarWeekView.refreshWeekView()
            }
            // Update Date
            if selectedData.date != viewModel.currentSelectedData.date {
                calendarWeekView.updateWeekView(to: selectedData.date)
            }
            // Update Scroll Type
            if selectedData.scrollType != viewModel.currentSelectedData.scrollType {
                calendarWeekView.scrollType = selectedData.scrollType
                // If you want to change the scrollType without forceReload, you should call setHorizontalEdgesOffsetX
                calendarWeekView.setHorizontalEdgesOffsetX()
            }
            // Update FirstDayOfWeek
            if selectedData.firstDayOfWeek != viewModel.currentSelectedData.firstDayOfWeek {
                calendarWeekView.updateFirstDayOfWeek(setDate: selectedData.date, firstDayOfWeek: selectedData.firstDayOfWeek)
            }
            // Update hourGridDivision
            if selectedData.hourGridDivision != viewModel.currentSelectedData.hourGridDivision {
                calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: selectedData.hourGridDivision))
            }
            // Update scrollableRange
            if selectedData.scrollableRange != viewModel.currentSelectedData.scrollableRange {
                calendarWeekView.scrollableRange = selectedData.scrollableRange
            }
        }

        private func updateNaviBarTitle() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM YYYY"
            self.navigationItem.title = dateFormatter.string(from: calendarWeekView.initDate.add(component: .day, value: calendarWeekView.numOfDays))
        }
    }
