//
//  ViewController.swift
//  Lab1_CurrencyConverter
//
//  Created by Louise Bergman on 2017-11-15.
//  Copyright © 2017 Louise Bergman. All rights reserved.
//

import UIKit

//var CurrencyNames:[String] = ["EUR", "USD", "GBP", "CNY", "JPY", "KRW", "SEK"]
//var CurrencyValues:[Double] = [0.10, 0.11, 0.09, 0.73, 12.91, 120.48, 1]
var CurrencyNamesSE:[String] = []
var CurrencyValuesSE:[Double] = []

class HomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //var choosenCurrency:Double = 0
    //var choosenCurrencyName = ""
    
    @IBOutlet weak var activeCurrencyText: UITextField!
    @IBOutlet weak var CurrencyList: UIPickerView!
    @IBOutlet weak var CurrencyList2: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    var toCurrency:Double = 0
    var fromCurrency:Double = 0
    //Fyll pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyNamesSE.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CurrencyNamesSE[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if(pickerView == CurrencyList)
        {
            fromCurrency = CurrencyValuesSE[row]
            
            if(activeCurrencyText.text != "")
            {
                activeCurrencyText.resignFirstResponder()
                let CurrencySEK = (Double(activeCurrencyText.text!)!/fromCurrency)
                resultLabel.text = String(CurrencySEK * toCurrency)
            }
            if(activeCurrencyText.text == "")
            {
                resultLabel.text = ""
            }
        }
        
        if(pickerView == CurrencyList2)
        {
            toCurrency = CurrencyValuesSE[row]
            
            if(activeCurrencyText.text != "")
            {
                activeCurrencyText.resignFirstResponder()
                let CurrencySEK = (Double(activeCurrencyText.text!)!/fromCurrency)
                resultLabel.text = String(CurrencySEK * toCurrency)
            }
            if(activeCurrencyText.text == "")
            {
                resultLabel.text = ""
            }
        }
        
    }
    
    @IBAction func ConvertionRates(_ sender: UIButton) {
        self.performSegue(withIdentifier: "RatesViewSegue", sender: self)
    }
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if(activeCurrencyText.text != "")
        {
            activeCurrencyText.resignFirstResponder()
            let CurrencySEK = (Double(activeCurrencyText.text!)!/fromCurrency)
            resultLabel.text = String(CurrencySEK * toCurrency)
        }
        if(activeCurrencyText.text == "")
        {
            resultLabel.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        view.addGestureRecognizer(gesture)
        
        let url = URL(string: "https://api.fixer.io/latest?base=SEK")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil
            {
                print("ERROR!!")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                CurrencyNamesSE.append((key as? String)!)
                                CurrencyValuesSE.append((value as? Double)!)
                            }
                            CurrencyNamesSE.append("SEK")
                            CurrencyValuesSE.append(1)
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
            self.CurrencyList.reloadAllComponents()
            self.CurrencyList2.reloadAllComponents()
            
            let locale = Locale.current
            if(locale.regionCode == "SE")
            {
                for i in 0..<CurrencyNamesSE.count
                {
                    if CurrencyNamesSE[i] == "SEK"
                    {
                        self.CurrencyList.selectRow(i, inComponent: 0, animated: true)
                        self.CurrencyList2.selectRow(i, inComponent: 0, animated: true)
                         self.fromCurrency = CurrencyValuesSE[i]
                         self.toCurrency = CurrencyValuesSE[i]
                        
                    }
                }
            }
            else if(locale.regionCode == "US")
            {
                for i in 0..<CurrencyNamesSE.count
                {
                    if CurrencyNamesSE[i] == "USD"
                    {
                        self.CurrencyList.selectRow(i, inComponent: 0, animated: true)
                        self.CurrencyList2.selectRow(i, inComponent: 0, animated: true)
                        self.fromCurrency = CurrencyValuesSE[i]
                        self.toCurrency = CurrencyValuesSE[i]
                    }
                }
            }
            else if(locale.regionCode == "UK")
            {
                for i in 0..<CurrencyNamesSE.count
                {
                    if CurrencyNamesSE[i] == "GBP"
                    {
                        self.CurrencyList.selectRow(i, inComponent: 0, animated: true)
                        self.CurrencyList2.selectRow(i, inComponent: 0, animated: true)
                        self.fromCurrency = CurrencyValuesSE[i]
                        self.toCurrency = CurrencyValuesSE[i]
                    }
                }
            }
            else if(locale.regionCode == "EU")
            {
                for i in 0..<CurrencyNamesSE.count
                {
                    if CurrencyNamesSE[i] == "EUR"
                    {
                        self.CurrencyList.selectRow(i, inComponent: 0, animated: true)
                        self.CurrencyList2.selectRow(i, inComponent: 0, animated: true)
                        self.fromCurrency = CurrencyValuesSE[i]
                        self.toCurrency = CurrencyValuesSE[i]
                    }
                }
            }
            else
            {
                for i in 0..<CurrencyNamesSE.count
                {
                    if CurrencyNamesSE[i] == "EUR"
                    {
                        self.CurrencyList.selectRow(i, inComponent: 0, animated: true)
                        self.CurrencyList2.selectRow(i, inComponent: 0, animated: true)
                        self.fromCurrency = CurrencyValuesSE[i]
                        self.toCurrency = CurrencyValuesSE[i]
                    }
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

