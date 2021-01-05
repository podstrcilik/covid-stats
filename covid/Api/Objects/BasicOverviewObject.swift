//
//  BasicOverviewObject.swift
//  covid
//
//  Created by Pavel Odstrčilík on 30.12.2020.
//

import Foundation
import RealmSwift
import ObjectMapper

class BasicOverviewObject: Object, Mappable {
    @objc dynamic var modified: String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        modified <- map["modified"]
    }
}

open class BasicOverviewDataObject: Object, Mappable {
    @objc dynamic var date: String = ""
    @objc dynamic var totalTestsPerformed: Int = 0
    @objc dynamic var totalConfirmedCases: Int = 0
    @objc dynamic var activeCases: Int = 0
    @objc dynamic var recovered: Int = 0
    @objc dynamic var deaths: Int = 0
    @objc dynamic var currentlyHospitalized: Int = 0
    @objc dynamic var testsPerformedYesterday: Int = 0
    @objc dynamic var confirmedCasesYesterday: Int = 0
    @objc dynamic var confirmedCasesToday: Int = 0
    @objc dynamic var testsPerformedYesterdayDate: String = ""
    @objc dynamic var confirmedCasesYesterdayDate: String = ""
    @objc dynamic var confirmedCasesTodayDate: String = ""


    required convenience public init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        date <- map["datum"]
        totalTestsPerformed <- map["provedene_testy_celkem"]
        totalConfirmedCases <- map["potvrzene_pripady_celkem"]
        activeCases <- map["aktivni_pripady"]
        recovered <- map["vyleceni"]
        deaths <- map["umrti"]
        currentlyHospitalized <- map["aktualne_hospitalizovani"]
        testsPerformedYesterday <- map["provedene_testy_vcerejsi_den"]
        confirmedCasesYesterday <- map["potvrzene_pripady_vcerejsi_den"]
        confirmedCasesToday <- map["potvrzene_pripady_dnesni_den"]
        testsPerformedYesterdayDate <- map["provedene_testy_vcerejsi_den_datum"]
        confirmedCasesYesterdayDate <- map["potvrzene_pripady_vcerejsi_den_datum"]
        confirmedCasesTodayDate <- map["potvrzene_pripady_dnesni_den_datum"]
    }
}
