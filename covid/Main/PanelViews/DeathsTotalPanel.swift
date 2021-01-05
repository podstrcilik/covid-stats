//
//  DeathsTotalPanel.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation

open class DeathsTotalPanel: CorePanelView {

    open override func prepareWrapperView() {
        super.prepareWrapperView()
        wrapperView.backgroundColor = .systemGray3
    }

    open override func prepareTopLabel() {
        super.prepareTopLabel()
        topLabel.text = "Úmrtí celkem"
    }

    open override func updateView() {
        guard let data = RealmService.shared.realm.objects(BasicOverviewDataObject.self).first else {
            return
        }
        middleLabel.text = "\(data.deaths.formattedWithSeparator)"
    }
}
