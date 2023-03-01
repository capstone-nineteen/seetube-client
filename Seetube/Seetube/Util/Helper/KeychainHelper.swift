//
//  KeychainHelper.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/01.
//

import Foundation
import KeychainAccess

final class KeychainHelper {
    enum Items: String {
        case accessToken
    }
    
    static let standard = KeychainHelper()
    private let keychain = Keychain(service: "com.SoojeongChoi.Seetube")
    private init() {}
    
    var accessToken: String? {
        get { self.retrieveItem(.accessToken) }
        set { self.saveItem(value: newValue, .accessToken) }
    }
    
    private func retrieveItem(_ item: Items) -> String? {
        return self.keychain[string: item.rawValue]
    }
    
    private func saveItem(value: String?, _ item: Items) {
        self.keychain[item.rawValue] = value
    }
}
