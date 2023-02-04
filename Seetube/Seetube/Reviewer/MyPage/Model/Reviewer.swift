//
//  Reviewer.swift
//  Seetube
//
//  Created by 최수정 on 2023/02/04.
//

import Foundation

struct Reviewer: Decodable {
    var name: String
    var coin: Int
    var histories: [CoinHistory]
}
