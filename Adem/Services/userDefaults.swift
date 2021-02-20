//
//  userDefaults.swift
//  Adem
//
//  Created by Coleman Coats on 2/20/21.
//  Copyright © 2021 Coleman Coats. All rights reserved.
//

import Foundation


//MARK: Apple Defaults
let defaults = UserDefaults.standard

let currentListID = defaults.value(forKey: "listId")
let fireBaseUsersName = defaults.value(forKey: "FirstName")
let homeListID = defaults.value(forKey: "uid")
let currentUserStatus = defaults.value(forKey: "isAnonymous")


extension UserDefaults {
    @objc dynamic var icon: String {
        return string(forKey: "icon")!
    }
    @objc dynamic var listId: String {
        return string(forKey: "listId")!
    }
}

//class Person: NSObject {
////https://nalexn.github.io/kvo-guide-for-key-value-observing/
//    @objc dynamic var icon: String?
//}
//
//class PersonObserver {
//
//    var kvoToken: NSKeyValueObservation?
//
//    func observe(person: Person) {
//        kvoToken = person.observe(\.icon, options: .new) { (person, change) in
//            guard let age = change.newValue else { return }
//            print("New age is: \(age)")
//        }
//    }
//
//    deinit {
//        kvoToken?.invalidate()
//    }
//}



/*
@propertyWrapper
struct UserDefault<T: PropertyListValue> {
 //https://www.vadimbulavin.com/advanced-guide-to-userdefaults-in-swift/
    let key: Key

    var wrappedValue: T? {
        get { defaults.value(forKey: key.rawValue) as? T }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }
    
    var projectedValue: UserDefault<T> { return self }
    
    func observe(change: @escaping (T?, T?) -> Void) -> NSObject {
        return UserDefaultsObservation(key: key) { old, new in
            change(old as? T, new as? T)
        }
    }
}

struct Key: RawRepresentable {
    let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}

// The marker protocol
protocol PropertyListValue {}

extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

class UserDefaultsObservation: NSObject {
    let key: Key
    private var onChange: (Any, Any) -> Void

    init(key: Key, onChange: @escaping (Any, Any) -> Void) {
        self.onChange = onChange
        self.key = key
        super.init()
        defaults.addObserver(self, forKeyPath: key.rawValue, options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, object != nil, keyPath == key.rawValue else { return }
        onChange(change[.oldKey] as Any, change[.newKey] as Any)
    }
    
    deinit {
        defaults.removeObserver(self, forKeyPath: key.rawValue, context: nil)
    }
}


extension Key {
    static let email: Key = "email"
    static let FirstName: Key = "FirstName"
    static let LastName: Key = "LastName"
    //static let Password: Key = "Password"
    static let homeName: Key = "homeName"
    static let icon: Key = "icon"
    static let isAnonymous: Key = "isAnonymous"
    static let listId: Key = "listId"
    static let listIsShared: Key = "listIsShared"
    static let pantryIsShared: Key = "pantryIsShared"
    static let uid: Key = "uid"

}

struct Storage {
    @UserDefault(key: .icon)
    var icon: String?
}

var storage = Storage()

var observation = storage.$icon.observe { old, new in
    print("Changed from: \(old as Optional) to \(new as Optional)")
}
*/
