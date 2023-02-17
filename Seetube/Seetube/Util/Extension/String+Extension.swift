//
//  String+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/18.
//

import Foundation

extension String {
    var urlPathAllowedEncoded: String {
        if let encoded = self.addingPercentEncoding(
            withAllowedCharacters: .urlPathAllowed
        ) {
            return encoded
        } else {
            return self
        }
    }
}
