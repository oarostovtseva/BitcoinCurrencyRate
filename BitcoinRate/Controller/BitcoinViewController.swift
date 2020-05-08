//
//  ViewController.swift
//  BitcoinRate
//
//  Created by Olena Rostovtseva on 08.05.2020.
//  Copyright © 2020 orost. All rights reserved.
//

import UIKit

class BitcoinViewController: UIViewController {
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!

    let coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.coinUpdateDelegate = self
    }
}

// MARK: - UIPickerViewDataSource section

extension BitcoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
}

// MARK: - UIPickerViewDelegate section

extension BitcoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}

// MARK: - CoinUpdateDelegate section

extension BitcoinViewController: CoinUpdateDelegate {
    func coinDidUpdate(coin: CoinModel) {
        DispatchQueue.main.async {
            self.rateLabel.text = String(format: "%.4f", coin.rate)
            self.currencyLabel.text = coin.coin
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
