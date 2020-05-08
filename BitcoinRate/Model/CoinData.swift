//
//  CoinData.swift
//  BitcoinRate
//
//  Created by Olena Rostovtseva on 08.05.2020.
//  Copyright © 2020 orost. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let asset_id_quote: String
    let rate: Double
}
