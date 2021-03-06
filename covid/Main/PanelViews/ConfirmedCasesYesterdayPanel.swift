//
//  ConfirmedCasesYesterdayPanel.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation
import UIKit

open class ConfirmedCasesYesterdayPanel: CorePanelView {
    
    open override func prepareWrapperView() {
        super.prepareWrapperView()
        wrapperView.backgroundColor = .systemPink
    }

    open override func updateView() {
        guard let data = RealmService.shared.realm.objects(BasicOverviewDataObject.self).first else {
            return
        }
        topLabel.text = "Potvrzené případy včera"
        middleLabel.text = "+ \(data.confirmedCasesYesterday.formattedWithSeparator)"
        bottomLabel.text = getFormattedDate(date: data.confirmedCasesYesterdayDate)
    }

    open override func styleLabel(label: UILabel, weight: UIFont.Weight = .regular, fontSize: CGFloat = 19) {
        super.styleLabel(label: label, weight: weight, fontSize: fontSize)
        label.textColor = .white
    }
}
