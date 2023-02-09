//
//  Int+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/09.
//

import Foundation

extension Int {
    func toFormattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
