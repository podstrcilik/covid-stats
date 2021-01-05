//
//  RegionOverviewDataObject.swift
//  covid
//
//  Created by Pavel Odstrčilík on 01.01.2021.
//

import Foundation
import RealmSwift
import ObjectMapper

open class RegionOverviewDataObject: Object, Mappable {
    @objc dynamic var date: String = ""
    @objc dynamic var regionCode: String = ""
    @objc dynamic var districtCode: String = ""
    @objc dynamic var testsPerformed: Int = 0

    required convenience public init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        date <- map["datum"]
        regionCode <- map["kraj_nuts_kod"]
        districtCode <- map["okres_lau_kod"]
        testsPerformed <- map["prirustkovy_pocet_testu_kraj"]
    }
}


open class RegionObject: Object {
    @objc dynamic var region: String = ""
}
