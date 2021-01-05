//
//  TestsPerformedByRegionPanel.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation
import UIKit

open class TestsPerformedByRegionPanel: CorePanelView {

    open override func prepareWrapperView() {
        super.prepareWrapperView()
        wrapperView.backgroundColor = .systemPurple
    }

    open override func prepareView() {
        super.prepareView()
        prepareArrowImageView()
    }

    open override func prepareTopLabel() {
        super.prepareTopLabel()
        topLabel.text = "Provedené testy dle krajů včera"
    }

    open func prepareArrowImageView() {
        let image = UIImage.init(systemName: "chevron.right")
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white
        wrapperView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(offset)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
    }

    open override func styleLabel(label: UILabel, weight: UIFont.Weight = .regular, fontSize: CGFloat = 19) {
        super.styleLabel(label: label, weight: weight, fontSize: fontSize)
        label.textColor = .white
    }
}
