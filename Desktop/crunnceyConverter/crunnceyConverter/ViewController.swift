//
//  ViewController.swift
//  crunnceyConverter
//
//  Created by Admin on 27/06/2021.
//  Copyright © 2021 Ashraf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var crunceyLabel: UILabel!
    
    @IBOutlet var crunceyPiker: UIPickerView!
    @IBOutlet var bitCoinLabel: UILabel!
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
              crunceyPiker.dataSource = self
              crunceyPiker.delegate = self
        
    }


}
extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        
        DispatchQueue.main.async {
            self.bitCoinLabel.text = price
            self.crunceyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return coinManager.currencyArray.count
      }
      
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return coinManager.currencyArray[row]
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          let selectedCurrency = coinManager.currencyArray[row]
          coinManager.getCoinPrice(for: selectedCurrency)
      }
}
