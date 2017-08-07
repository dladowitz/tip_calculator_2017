//
//  ViewController.swift
//  tip_calculator
//
//  Created by david ladowitz on 8/5/17.
//  Copyright © 2017 LittleCatLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    @IBOutlet weak var totalViewContainer: UIView!
    @IBOutlet var mainViewContainer: UIView!
    @IBOutlet weak var splitAmountLabel: UILabel!
    @IBOutlet weak var splitCountLabel: UITextField!

    let tipAmounts:Array<Double> = [0.10, 0.16, 0.18, 0.20, 0.25]
    let currencies:Array<String> = ["en_US", "en_GB", "es_ES", "ja_JP"]
    let currencieSymbols:Array<String> = ["$", "£", "€", "¥"]


    var currency = ""
    var currencySymbol = ""
    var textBillWithoutCommasLastLength = 0

    var tip = 0.0
    var total = 0.0

    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController view viewDidLoad")

        billField.becomeFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController view will appear")


//      Set Currency
        let currencyIndex = defaults.integer(forKey: "currencyIndex")
        self.currency = currencies[currencyIndex]
        self.currencySymbol = currencieSymbols[currencyIndex]
        print("Current Currency is: ", currency)


//      Set defualt tip percentage
        let defualtTipPercentageIndex = defaults.integer(forKey: "defaultTipPercentageIndex")
        tipPercent.selectedSegmentIndex = defualtTipPercentageIndex


//      Use the last bill amount if it was set less than 10 minutes ago
        let lastBillTime = defaults.integer(forKey: "lastBillTime")
        let currentTimeInMiliseconds = Int(Date().timeIntervalSince1970)

        if ((lastBillTime + 600) > currentTimeInMiliseconds){
            let lastBillAmount = defaults.object(forKey: "lastBillAmount") as! String?
            billField.text = lastBillAmount
        }


//      Format UITextField
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        calculateTip(Any.self)
    }


    @IBAction func changeTip(_ sender: Any) {
        print("changed tip amount")

        // Highlight new total
        if (totalLabel.text != "$0.00"){
            UIView.animate(withDuration: 0.6, animations: {
                self.totalViewContainer.backgroundColor = UIColor(red:201/255, green:140/255, blue:86/255, alpha:1.0)

            })
            UIView.animate(withDuration: 0.6, animations: {
                self.totalViewContainer.backgroundColor = UIColor(red:201/255, green:140/255, blue:86/255, alpha:0.0)
                
            })

            calculateTip(Any.self)
        }
    }



//  Should break this up into a bunch of small methods with more time
    @IBAction func calculateTip(_ sender: Any) {
        let textBill = billField.text

//      Drop the cents here to effectively multiply by 100
        var textBillWithoutCommas = textBill?.replacingOccurrences(of: ",|£|¥|€|\\$|\\.|\\s", with: "", options: .regularExpression, range: nil)


//      Can't delete because currency symbol is blocking
        if (currencySymbol == "€") && (self.textBillWithoutCommasLastLength == (textBillWithoutCommas?.characters.count)!) {
//          Something funny happens with 2 and 3 characters
            textBillWithoutCommas = textBillWithoutCommas?.substring(to: (textBillWithoutCommas?.index(before: (textBillWithoutCommas?.endIndex)!))!)
        }
        self.textBillWithoutCommasLastLength = (textBillWithoutCommas?.characters.count)!


        let doubleBillInCents = Double(textBillWithoutCommas!) ?? 0


//      Set currency through Local
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: self.currency)
        formatter.numberStyle = .currency

//      calculate numerical amount of tip and total
        let selectedTipAmount = Double(tipAmounts[tipPercent.selectedSegmentIndex])


//      Yen don't have cents
        if currencySymbol == "¥" {
            tip  = (doubleBillInCents * selectedTipAmount)
            total = doubleBillInCents + tip

            if let formattedBillAmount = formatter.string(from: doubleBillInCents as NSNumber) {
                billField.text = formattedBillAmount
            }
        } else {
            tip  = (doubleBillInCents * selectedTipAmount) / 100
            total = doubleBillInCents/100 + tip

            if let formattedBillAmount = formatter.string(from: doubleBillInCents/100 as NSNumber) {
                billField.text = formattedBillAmount
            }
        }


//      Write to text input field
        if let formattedTipAmount = formatter.string(from: tip as NSNumber) {
            tipLabel.text = formattedTipAmount
        }

//      Set tip and total with current currency
        if let formattedTotalAmount = formatter.string(from: total as NSNumber) {
            totalLabel.text = formattedTotalAmount
        }

//      Save bill to UserDefaults to be used for the next 10 min
        let currentTimeInMiliseconds = Date().timeIntervalSince1970

        defaults.set(billField.text, forKey: "lastBillAmount")
        defaults.set(currentTimeInMiliseconds, forKey: "lastBillTime")
        defaults.synchronize()

        calculateSplit(Any.self)
    }

    @IBAction func calculateSplit(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: self.currency)
        formatter.numberStyle = .currency

        var totalWithoutCommas = ""
        if (currencySymbol == "€") {
            totalWithoutCommas = (totalLabel.text?.replacingOccurrences(of: "€|\\s|\\.", with: "", options: .regularExpression, range: nil))!
            totalWithoutCommas = (totalWithoutCommas.replacingOccurrences(of: ",", with: ".", options: .regularExpression, range: nil))
        } else {
            totalWithoutCommas = (totalLabel.text?.replacingOccurrences(of: ",|£|¥|€|\\$|\\s", with: "", options: .regularExpression, range: nil))!
        }


        let splitAmount = Double(totalWithoutCommas)! / (Double(splitCountLabel.text!) ?? 1)
        if let formattedSplitAmount = formatter.string(from: splitAmount as NSNumber) {
            splitAmountLabel.text = formattedSplitAmount
        }

    }

}

