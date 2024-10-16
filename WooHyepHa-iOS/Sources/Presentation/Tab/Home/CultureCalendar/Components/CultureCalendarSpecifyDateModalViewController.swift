//
//  CultureCalendarSpecifyDateModalViewController.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/16/24.
//

import UIKit

import RxCocoa
import RxSwift
import Then
import SnapKit
import FSCalendar

class CultureCalendarSpecifyDateModalViewController: BaseViewController {
    
    private let calendar = DateHelper.shared.calendar
    
    // 현재 캘린더가 보여주고 있는 페이지 트래킹 변수
    private lazy var currentPage = calendarView.currentPage
    
    private var selectedStartDate: Date?
    private var selectedEndDate: Date?

    private let prevButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.backgroundColor = .gray9
        $0.tintColor = .gray4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray8.cgColor
        $0.layer.cornerRadius = 3
        //$0.addViewShadow()
    }
    
    private let nextButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .gray4
        $0.backgroundColor = .gray9
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray8.cgColor
        $0.layer.cornerRadius = 3
        //$0.addViewShadow()
    }
    
    private lazy var calendarView = FSCalendar().then {
        $0.delegate = self
        $0.dataSource = self
        
        $0.backgroundColor = .white
        $0.register(CalendarCell.self, forCellReuseIdentifier: "CalendarCell")
        
        $0.scope = .month
        $0.locale = Locale(identifier: "ko_KR")
        $0.placeholderType = .none
        
        $0.headerHeight = 90
        $0.appearance.titleDefaultColor = .gray1
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.appearance.headerTitleColor = .gray1
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerTitleFont = UIFont.sub4
        
        $0.appearance.titleFont = UIFont.systemFont(ofSize: 15)
        $0.appearance.todayColor = .orange
        $0.appearance.titleTodayColor = .gray1
        
        $0.appearance.selectionColor = .MainColor
        $0.allowsMultipleSelection = true
    }
    
    private let borderView = UIView().then {
        $0.backgroundColor = .gray9
    }
    
    private let resetButton = UIButton().then {
        $0.setTitle("초기화", for: .normal)
        $0.setTitleColor(.gray1, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray8
        $0.layer.cornerRadius = 10
    }    
    
    private let applyButton = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .body2
        $0.backgroundColor = .gray1
        $0.layer.cornerRadius = 10
    }
    
    private let buttonStackView = UIStackView().then {
        $0.distribution = .fillProportionally
        $0.axis = .horizontal
        $0.spacing = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeWeekdayView()
    }
    
    override func setViewController() {
        view.backgroundColor = .white
        [calendarView, prevButton, nextButton, borderView, buttonStackView].forEach {
            view.addSubview($0)
        }
        
        [resetButton, applyButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
    }

    override func setConstraints() {
        calendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(350)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        prevButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarView.calendarHeaderView)
            $0.leading.equalTo(calendarView.calendarHeaderView.snp.leading).offset(10)
            $0.width.height.equalTo(25)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalTo(calendarView.calendarHeaderView)
            $0.trailing.equalTo(calendarView.calendarHeaderView.snp.trailing).inset(10)
            $0.width.height.equalTo(25)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(24)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func bind() {
        prevButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.moveMonth(next: false)
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.moveMonth(next: true)
            })
            .disposed(by: disposeBag)
    }
}

extension CultureCalendarSpecifyDateModalViewController {
    func showModal(vc: UIViewController) {
        let modalVC = CultureCalendarSpecifyDateModalViewController()
        
        if let sheet = modalVC.sheetPresentationController {
            let fixedDetent = UISheetPresentationController.Detent.custom { context in
                return 450
            }
            
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = false
            sheet.detents = [fixedDetent]
        }
        
        vc.present(modalVC, animated: true)
    }
}

private extension CultureCalendarSpecifyDateModalViewController {
    func moveMonth(next: Bool) {
        var dateComponents = DateComponents()
        dateComponents.month = next ? 1 : -1
        self.currentPage = Calendar.current.date(byAdding: dateComponents, to: self.currentPage)!
        calendarView.setCurrentPage(self.currentPage, animated: true)
    }
    
    func selectDateRange() {
        guard let start = selectedStartDate, let end = selectedEndDate else { return }
        
        var date = start
        while date <= end {
            if !calendarView.selectedDates.contains(date) {
                calendarView.select(date)
            }
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
    }
    
    func deselectAllDates() {
        for date in calendarView.selectedDates {
            calendarView.deselect(date)
        }
    }

    func customizeWeekdayView() {
           // FSCalendar의 weekdayLabels를 가져옵니다.
           let weekdayLabels = calendarView.calendarWeekdayView.weekdayLabels

           // 일요일(0)과 토요일(6)의 색상을 라이트 그레이로 설정하고 나머지는 흰색으로 설정
           for (index, label) in weekdayLabels.enumerated() {
               if index == 0 || index == 6 {
                   //label.textColor = UIColor.lightGray
                   label.textColor = UIColor.gray4
               } else {
                   //label.textColor = UIColor.white
                   label.textColor = UIColor.gray4
               }
           }
       }
    
    func configureCell(_ cell: FSCalendarCell?, for date: Date?, at position: FSCalendarMonthPosition) {
        guard let cell = cell as? CalendarCell, let date = date else { return }
        
        var selectionType = SelectionType.none
        
        if calendarView.selectedDates.contains(date) {
            if date == selectedStartDate {
                selectionType = .leftBorder
            } else if date == selectedEndDate {
                selectionType = .rightBorder
            } else if let start = selectedStartDate, let end = selectedEndDate,
                      date > start && date < end {
                selectionType = .middle
            } else {
                selectionType = .single
            }
        } else if date.isEqual() {
            selectionType = .today
        }
        
        cell.selectionType = selectionType
        cell.setNeedsLayout()
    }
    
    private func updateSelectedDates() {
        guard let start = selectedStartDate, let end = selectedEndDate else { return }
        
        calendarView.selectedDates.forEach { calendarView.deselect($0) }
        
        var date = start
        while date <= end {
            calendarView.select(date)
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
    }
    
    private func configureVisibleCells() {
        calendarView.visibleCells().forEach { (cell) in
            let date = calendarView.date(for: cell)
            let position = calendarView.monthPosition(for: cell)
            configureCell(cell, for: date, at: position)
        }
    }
}

extension CultureCalendarSpecifyDateModalViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(
            withIdentifier: "CalendarCell",
            for: date,
            at: position
        )
        return cell
    }
}

extension CultureCalendarSpecifyDateModalViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.configureCell(cell, for: date, at: monthPosition)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if selectedStartDate == nil {
            selectedStartDate = date
            selectedEndDate = nil
        } else if selectedEndDate == nil && date > selectedStartDate! {
            selectedEndDate = date
            print()
            updateSelectedDates()
        } else {
            selectedStartDate = date
            selectedEndDate = nil
            calendarView.selectedDates.forEach { calendarView.deselect($0) }
            calendarView.select(date)
        }
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedStartDate = nil
        selectedEndDate = nil
        calendarView.selectedDates.forEach { calendarView.deselect($0) }
        self.configureVisibleCells()
    }
}
