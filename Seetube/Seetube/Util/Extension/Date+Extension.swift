//
//  Date+Extension.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/10.
//

import Foundation

extension Date {
    func toyyMMddStyleWithDot() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }
}
