//
//  CurrencyManager.swift
//  currency-conveter
//
//  Created by Shruti Jain on 2020/01/28.
//  Copyright © 2020 Shruti Jain. All rights reserved.
//

import Foundation
protocol CurrencyManagerDelegate{
    func didUpdateAmount(_ currencyManager: CurrencyManager,currency: CurrencyData)
}
struct CurrencyManager{
    let currencyUrl = "https://api.exchangeratesapi.io/latest?&base=JPY";
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate:CurrencyManagerDelegate?
    
    func fetchCurrency(currencySymbol: String){
        let urlString = "\(currencyUrl)&symbols=\(currencySymbol)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url) { (data, response, error) in
                if(error != nil){
                    print(error!)
                }
                if let safeData = data {
                    if let currency = self.parseJSON(data: safeData){
                        self.delegate?.didUpdateAmount(self, currency: currency);
                };
                }
        }
                 task.resume()
      
            
    }
    }
    
    func parseJSON(data: Data) -> CurrencyData?{
        let decoder = JSONDecoder();
        do{
           let decodedData = try decoder.decode(CurrencyData.self, from: data)
            for (key, value) in decodedData.rates{
                let currency = CurrencyData(date: decodedData.date, rates: [key : value], base: decodedData.base)
                return currency;
            }
        }
        catch {
            print(error)
            return nil;
        }
        return nil;
    }
}

