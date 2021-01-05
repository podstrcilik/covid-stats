//
//  NumericExtension.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
