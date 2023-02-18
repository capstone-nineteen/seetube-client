//
//  SeeSo.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/19.
//

import Foundation

enum SeeSo {
    static let licenseKey = Bundle.main.infoDictionary?["SEESO_LICENSE_KEY"] as? String ?? ""
}
