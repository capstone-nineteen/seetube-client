//
//  CellReuseIdentifiable.swift
//  Seetube
//
//  Created by 최수정 on 2023/01/14.
//

import UIKit

public protocol CellReuseIdentifiable: UITableViewCell {
    static var cellReuseIdentifier: String { get }
}
