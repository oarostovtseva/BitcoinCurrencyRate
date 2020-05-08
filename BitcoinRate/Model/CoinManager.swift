//
//  File.swift
//  BitcoinRate
//
//  Created by Olena Rostovtseva on 08.05.2020.
//  Copyright © 2020 orost. All rights reserved.
//

import Foundation

class CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "88846635-07D3-4109-9ED9-5315D9F6E9E4"

    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

    var coinUpdateDelegate: CoinUpdateDelegate?

    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }

    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: url) { data, _, error in
                if let safeError = error {
                    print(error)
                    self.coinUpdateDelegate?.didFailWithError(error: safeError)
                    return
                }
                if let safeData = data {
                    if let coinModel = self.parseJson(safeData) {
                        self.coinUpdateDelegate?.coinDidUpdate(coin: coinModel)
                    }
                }
            }

            dataTask.resume()
        }
    }

    func parseJson(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let coinModel = CoinModel(coin: decodedData.asset_id_quote, rate: decodedData.rate)
            return coinModel
        } catch {
            print(error)
            coinUpdateDelegate?.didFailWithError(error: error)
            return nil
        }
    }
}
