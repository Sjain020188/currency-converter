//
//  ViewController.swift
//  currency-conveter
//
//  Created by Shruti Jain on 2020/01/24.
//  Copyright © 2020 Shruti Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, CurrencyManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    

    @IBOutlet weak var CurrencyPicker: UIPickerView!
    @IBOutlet weak var EnteredAmount: UITextField!
    @IBOutlet weak var ConvertedAmount: UILabel!
    var currencySelected = "AUD"
    @IBAction func ConvertButton(_ sender: Any) {
        if(EnteredAmount.text != ""){
            currency.fetchCurrency(currencySymbol: currencySelected)
        } else {
            EnteredAmount.placeholder = "Please enter some amount"
        }
       
    }
    
    var currency = CurrencyManager();
   
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyPicker.dataSource = self;
        CurrencyPicker.delegate = self;
        currency.delegate = self;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return currency.currencyArray.count
    
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencySelected = currency.currencyArray[row];
        currency.fetchCurrency(currencySymbol: currency.currencyArray[row])
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true);
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true
        }else{
            textField.placeholder = "please enter some amount";
            return false;
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        EnteredAmount.text = ""
    }
    
    func didUpdateAmount(_ currencyManager: CurrencyManager,currency: CurrencyData){
        DispatchQueue.main.async{
            for (_,value) in currency.rates{
                self.ConvertedAmount.text = "1 JPY = \(String(value)) \(self.currencySelected)"
            }
        }
    }


}

