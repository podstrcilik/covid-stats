//
//  FormatterExtension.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}
