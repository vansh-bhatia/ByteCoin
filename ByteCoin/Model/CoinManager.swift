import Foundation



struct CoinManager {

    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "27101DC7-3FF2-4F0B-8151-58D833975184"
    var delegate: CoinViewController?
    var currentRow = 0

    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

    func setURL(for currency: String) {
        let finalURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        //print(finalURL)
        performRequest(finalURL)
    }

    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coinData = self.parseJSON(safeData) {
                        //print("Price:\(coinData.rate)")
                        self.delegate?.updatePrice(coinManager: self, coinData)
                    }
                }
            }
            task.resume()
        }

    }

    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: coinData)

            let price = Double(decodedData.rate)
            let coin = CoinModel(rate: price)
            return coin
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
