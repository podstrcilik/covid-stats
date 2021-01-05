//
//  RequestType.swift
//  covid
//
//  Created by Pavel Odstrčilík on 31.12.2020.
//

import Foundation

enum RequestType {
    case basicOverview
    case regionsOverview

    var url: String {
        switch self {
        case .basicOverview:
            return "https://onemocneni-aktualne.mzcr.cz/api/v2/covid-19/zakladni-prehled.json"
        case .regionsOverview:
            return "https://onemocneni-aktualne.mzcr.cz/api/v2/covid-19/kraj-okres-testy.json"
        }
    }
}
