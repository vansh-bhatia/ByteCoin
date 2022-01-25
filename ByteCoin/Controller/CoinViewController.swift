import UIKit

class CoinViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!

    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1 // number of pickers
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count // number of choices
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.currentRow = row
        coinManager.setURL(for: coinManager.currencyArray[row])

    }

    func didFailWithError(error: Error) {
        print(error)
    }
    func updatePrice(coinManager: CoinManager, _ coin: CoinModel) {
        DispatchQueue.main.async {
            //print("Reached")
            //print(coin.rate)
            self.bitcoinLabel.text = String(format: "%.3f", coin.rate)
            self.currencyLabel.text = coinManager.currencyArray[coinManager.currentRow]
        }
    }

}

