//
//  CorePanelView.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import UIKit
import Foundation
import SnapKit

open class CorePanelView: UIView {
    public let wrapperView = UIView()
    public let topLabel = UILabel()
    public let middleLabel = UILabel()
    public let bottomLabel = UILabel()
    public let offset = 10

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 100)
    }

    init() {
        super.init(frame: CGRect.zero)
        prepareView()
        self.backgroundColor = .white
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func prepareView() {
        prepareWrapperView()
        prepareTopLabel()
        prepareMiddleLabel()
        prepareBottomLabel()
        updateView()
    }

    open func updateView() {}
    
    open func prepareWrapperView() {
        self.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
            make.height.equalTo(100)
            make.top.equalToSuperview()
        }
        wrapperView.backgroundColor = .darkGray
        wrapperView.isUserInteractionEnabled = true
        wrapperView.layer.masksToBounds = true
        wrapperView.layer.cornerRadius = 10
    }

    open func prepareTopLabel() {
        wrapperView.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(offset)
            make.leading.equalToSuperview().offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
        }
        styleLabel(label: topLabel)
    }

    open func prepareMiddleLabel() {
        wrapperView.addSubview(middleLabel)
        middleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(offset-4)
            make.leading.equalToSuperview().offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
        }
        styleLabel(label: middleLabel, weight: .semibold)
    }

    open func prepareBottomLabel() {
        wrapperView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(middleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
        }
        styleLabel(label: bottomLabel, fontSize: 17)
    }

    open func getFormattedDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"

        if let formatted = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: formatted)
        } else {
            return "N/A"
        }
    }

    open func styleLabel(label: UILabel, weight: UIFont.Weight = .regular, fontSize: CGFloat = 19) {
        label.font = .systemFont(ofSize: fontSize, weight: weight)
    }
}
