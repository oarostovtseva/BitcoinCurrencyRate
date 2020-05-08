//
//  CoinDelegate.swift
//  BitcoinRate
//
//  Created by Olena Rostovtseva on 08.05.2020.
//  Copyright © 2020 orost. All rights reserved.
//

import Foundation

protocol CoinUpdateDelegate {
    func coinDidUpdate(coin: CoinModel)
    func didFailWithError(error: Error)
}
