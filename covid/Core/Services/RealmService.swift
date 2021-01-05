//
//  RealmService.swift
//  covid
//
//  Created by Pavel Odstrčilík on 30.12.2020.
//

import Foundation
import RealmSwift

class RealmService {
    private init() {}
    static let shared = RealmService()

    var realm = try! Realm()

    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }

    func delete(type: Object.Type) {
        realm.beginWrite()
        realm.delete(realm.objects(type.self))
        do {
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
