//
//  CalendarCell.swift
//  WooHyepHa-iOS
//
//  Created by 여성일 on 10/16/24.
//

// 선택시 원 크기 키우고 정렬
// 토,일 요일 글씨 색상 라이트그레이 나머지 흰색
// 오늘 날짜 점찍기

import UIKit

import FSCalendar

enum SelectionType {
    case none // 선택 X
    case today // 오늘 날짜 선택
    case single // 단일 선택
    case leftBorder // 왼쪽 border
    case middle // 범위 선택 바
    case rightBorder // 오른쪽 border
}

class CalendarCell: FSCalendarCell {
    
    private weak var circleImageView: UIImageView?
    private weak var selectionLayer: CAShapeLayer?
    private weak var roundedLayer: CAShapeLayer?
    private weak var todayLayer: CAShapeLayer?
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.gray2.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel?.layer)
        self.selectionLayer = selectionLayer
        
        let roundedLayer = CAShapeLayer()
        roundedLayer.fillColor = UIColor.MainColor.cgColor
        roundedLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(roundedLayer, below: self.titleLabel?.layer)
        self.roundedLayer = roundedLayer
        
        let todayLayer = CAShapeLayer()
                todayLayer.fillColor = UIColor.lightGray.cgColor
                todayLayer.actions = ["hidden": NSNull()]
                self.contentView.layer.insertSublayer(todayLayer, below: self.titleLabel?.layer)
                self.todayLayer = todayLayer
        
        self.shapeLayer.isHidden = true
        let view = UIView(frame: self.bounds)
        self.backgroundView = view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.selectionLayer?.frame = self.contentView.bounds
        self.roundedLayer?.frame = self.contentView.bounds
        self.todayLayer?.frame = self.contentView.bounds
        
        let contentHeight = self.contentView.frame.height
        let contentWidth = self.contentView.frame.width
        
        let selectionLayerBounds = selectionLayer?.bounds ?? .zero
        let selectionLayerWidth = selectionLayer?.bounds.width ?? .zero
        let roundedLayerHeight = roundedLayer?.frame.height ?? .zero
        let roundedLayerWidth = roundedLayer?.frame.width ?? .zero
        
        let yOffset: CGFloat = -2.5  // 원과 선택 영역을 아래로 내리기 위한 오프셋
        
        switch selectionType {
        case .middle:
            self.selectionLayer?.isHidden = false
            self.roundedLayer?.isHidden = true
            self.todayLayer?.isHidden = true
            
            let selectionRect = selectionLayerBounds
                .insetBy(dx: 0.0, dy: 1.0)
                .offsetBy(dx: 0, dy: yOffset)
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath
            
        case .leftBorder, .rightBorder, .single:
            self.selectionLayer?.isHidden = (selectionType == .single)
            self.roundedLayer?.isHidden = false
            self.todayLayer?.isHidden = true
            
            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: contentWidth / 2 - diameter / 2,
                              y: (contentHeight / 2 - diameter / 2) + yOffset,
                              width: diameter,
                              height: diameter)
                .insetBy(dx: 1.0, dy: 1.0)
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath
            
            if selectionType != .single {
                let selectionRect = selectionLayerBounds
                    .insetBy(dx: selectionLayerWidth / 4, dy: 1.0)
                    .offsetBy(dx: selectionType == .leftBorder ? selectionLayerWidth / 4 : -selectionLayerWidth / 4, dy: yOffset)
                self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath
            }
            
        case .today:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = true
            self.todayLayer?.isHidden = false
            
            let dotDiameter: CGFloat = 4  // 점의 지름
            let dotYOffset: CGFloat = 4  // 텍스트 아래쪽으로부터의 거리
            let rect = CGRect(x: contentWidth / 2 - dotDiameter / 2 + 0.2,
                              y: contentHeight - dotDiameter - dotYOffset,
                              width: dotDiameter,
                              height: dotDiameter)
            self.todayLayer?.path = UIBezierPath(ovalIn: rect).cgPath

            
        case .none:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = true
            self.todayLayer?.isHidden = true
        }
    }
}
