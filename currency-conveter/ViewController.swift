//
//  ViewController.swift
//  currency-conveter
//
//  Created by Shruti Jain on 2020/01/24.
//  Copyright © 2020 Shruti Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, CurrencyManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var TargetCurrencyInput: UITextField!
    @IBOutlet weak var FromCurrencyInput: UITextField!
    @IBOutlet weak var EnteredAmount: UITextField!
    @IBOutlet weak var ConvertedAmount: UILabel!
    var TargetCurrencyPicker: UIPickerView! = UIPickerView()
    var FromCurrencyPicker: UIPickerView! = UIPickerView()
    var fromCurrencySelected = "JPY"
    var targetCurrencySelected = "AUD"
    
    @IBAction func ConvertButton(_ sender: Any) {
        if(EnteredAmount.text != ""){
            currency.fetchCurrency(targetCurrencySymbol: targetCurrencySelected, fromCurrencySymbol: fromCurrencySelected)
        } else {
            EnteredAmount.placeholder = "Please enter some amount"
        }
       
    }
    
    var currency = CurrencyManager();
   
    override func viewDidLoad() {
        super.viewDidLoad()
        TargetCurrencyInput.delegate = self;
        TargetCurrencyPicker.dataSource = self;
        TargetCurrencyPicker.delegate = self;
        TargetCurrencyPicker.tag = 2;
     
        FromCurrencyPicker.dataSource = self;
        FromCurrencyPicker.delegate = self;
        FromCurrencyPicker.tag = 1;
        currency.delegate = self;
        TargetCurrencyInput.inputView = TargetCurrencyPicker;
        FromCurrencyInput.inputView = FromCurrencyPicker;
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
        if(pickerView.tag == 1){
            FromCurrencyInput.text = currency.currencyArray[row];
            fromCurrencySelected = currency.currencyArray[row];
        }
        if(pickerView.tag == 2){
            TargetCurrencyInput.text = currency.currencyArray[row];
            targetCurrencySelected = currency.currencyArray[row];
            currency.fetchCurrency(targetCurrencySymbol: currency.currencyArray[row], fromCurrencySymbol: fromCurrencySelected)
        }
        
       
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
        
    }
    
    func didUpdateAmount(_ currencyManager: CurrencyManager,currency: CurrencyData){
        DispatchQueue.main.async{
            for (_,value) in currency.rates{
                let amount = Float(self.EnteredAmount.text!)
                self.ConvertedAmount.text = "\(String(self.EnteredAmount.text!)) \(self.fromCurrencySelected) = \(String(value * amount!)) \(self.targetCurrencySelected)"
            }
        }
    }
    
  
}
 
