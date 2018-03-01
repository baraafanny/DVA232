//
//  RatesViewController.swift
//  Lab1_CurrencyConverter
//
//  Created by Fanny Danielsson on 2017-11-17.
//  Copyright © 2017 Louise Bergman. All rights reserved.
//

import UIKit
struct Rates {
    var url: String
    var CurrencyNames:[String] = []
    var CurrencyValues:[Double] = []
}

class RatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrencyNamesSE.count-1
    }
    @IBOutlet weak var currencysTable: UITableView!
    var selected:Int = 0
    var RatesList: [Rates] = []
    var CurrencyNamesSEK:[String] = CurrencyNamesSE
    var CurrencyValuesSEK:[Double] = CurrencyValuesSE
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! CustomtableViewCell
            if(selected == 0)
            {
                let text = CurrencyNamesSE[indexPath.row]
                cell.Label1.text = text
                let text2 = CurrencyValuesSE[indexPath.row]
                cell.Label2.text = String(text2)
            }
            else if(selected == 1)
            {
                let text = RatesList[0].CurrencyNames[indexPath.row]
                cell.Label1.text = text
                let text2 = RatesList[0].CurrencyValues[indexPath.row]
                cell.Label2.text = String(text2)
                
            }
            else if(selected == 2)
            {
                let text = RatesList[1].CurrencyNames[indexPath.row]
                cell.Label1.text = text
                let text2 = RatesList[1].CurrencyValues[indexPath.row]
                cell.Label2.text = String(text2)
            }
            else if(selected == 3)
            {
                let text = RatesList[2].CurrencyNames[indexPath.row]
                cell.Label1.text = text
                let text2 = RatesList[2].CurrencyValues[indexPath.row]
                cell.Label2.text = String(text2)
            }
            else if(selected == 4)
            {
                let text = RatesList[3].CurrencyNames[indexPath.row]
                cell.Label1.text = text
                let text2 = RatesList[3].CurrencyValues[indexPath.row]
                cell.Label2.text = String(text2)
            }
            else if(selected == 5)
            {
                let text = RatesList[4].CurrencyNames[indexPath.row]
                cell.Label1.text = text
                let text2 = RatesList[4].CurrencyValues[indexPath.row]
                cell.Label2.text = String(text2)
            }
            else if(selected == 6)
            {
                let text = RatesList[5].CurrencyNames[indexPath.row]
                cell.Label1.text = text
                let text2 = RatesList[5].CurrencyValues[indexPath.row]
                cell.Label2.text = String(text2)
            }
            else if(selected == 7)
            {
                let text = RatesList[6].CurrencyNames[indexPath.row]
                cell.Label1.text = text
                let text2 = RatesList[6].CurrencyValues[indexPath.row]
                cell.Label2.text = String(text2)
                
            }
            return cell
        }
    
    @IBAction func CurrencyChooser(_ sender: UISegmentedControl) {
        selected = sender.selectedSegmentIndex
        currencysTable.reloadData()
    }
    
    @IBAction func BackButtonAction(_ sender: UIButton) {
       // self.performSegue(withIdentifier: "HomeViewSegue", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var ConvertionRates: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConvertionRates.tableFooterView=UIView()
        
        RatesList.append(Rates(url: "https://api.fixer.io/latest?base=EUR", CurrencyNames: [], CurrencyValues: []))
        RatesList.append(Rates(url: "https://api.fixer.io/latest?base=USD", CurrencyNames: [], CurrencyValues: []))
        RatesList.append(Rates(url: "https://api.fixer.io/latest?base=GBP", CurrencyNames: [], CurrencyValues: []))
        RatesList.append(Rates(url: "https://api.fixer.io/latest?base=CNY", CurrencyNames: [], CurrencyValues: []))
        RatesList.append(Rates(url: "https://api.fixer.io/latest?base=JPY", CurrencyNames: [], CurrencyValues: []))
        RatesList.append(Rates(url: "https://api.fixer.io/latest?base=KRW", CurrencyNames: [], CurrencyValues: []))
        
        for i in 0..<RatesList.count
        {
            let url = URL(string: RatesList[i].url)
            
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
                                    self.RatesList[i].CurrencyNames.append((key as? String)!)
                                    self.RatesList[i].CurrencyValues.append((value as? Double)!)
                                }
                            }
                        }
                        catch
                        {
                            
                        }
                    }
                }
            }
            task.resume()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var BackButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
