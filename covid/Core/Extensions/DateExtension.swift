//
//  DateExtension.swift
//  covid
//
//  Created by Pavel Odstrčilík on 01.01.2021.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
