//
//  ConfirmedCasesTodayPanel.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation
import UIKit

open class ConfirmedCasesTodayPanel: CorePanelView {

    open override func prepareWrapperView() {
        super.prepareWrapperView()
        wrapperView.backgroundColor = .systemRed
    }

    open override func updateView() {
        guard let data = RealmService.shared.realm.objects(BasicOverviewDataObject.self).first else {
            return
        }

        topLabel.text = "Potvrzené případy dnes"
        middleLabel.text = "+ \(data.confirmedCasesToday.formattedWithSeparator)"
        bottomLabel.text = getFormattedDate(date: data.confirmedCasesTodayDate)
    }

    open override func styleLabel(label: UILabel, weight: UIFont.Weight = .regular, fontSize: CGFloat = 19) {
        super.styleLabel(label: label, weight: weight, fontSize: fontSize)
        label.textColor = .white
    }
}
