//
//  Encodable+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/17.
//

import Foundation

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
