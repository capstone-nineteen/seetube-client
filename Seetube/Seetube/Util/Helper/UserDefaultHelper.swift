//
//  UserDefaultHelper.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/02.
//

import Foundation

final class UserDefaultHelper {
    enum Items: String {
        case userType
        case isInitialExecution
    }
    
    static let shared = UserDefaultHelper()
    private let userDefaults = UserDefaults.standard
    private init() {}
    
    var userType: UserType? {
        get {
            guard let userTypeRawValue: Int = self.retrieveItem(.userType) else { return nil }
            return UserType(rawValue: userTypeRawValue)
        }
        set { self.saveItem(value: newValue?.rawValue, .userType) }
    }
    
    var isInitialExecution: Bool {
        get { return self.retrieveItem(.isInitialExecution) ?? true }
        set { self.saveItem(value: newValue, .isInitialExecution) }
    }
    
    private func saveItem<T>(value: T?, _ item: Items) {
        userDefaults.set(value, forKey: item.rawValue)
    }
    
    private func retrieveItem<T>(_ item: Items) -> T? {
        return userDefaults.value(forKey: item.rawValue) as? T
    }
    
    private func removeItem(_ item: Items) {
        userDefaults.removeObject(forKey: item.rawValue)
    }
}
