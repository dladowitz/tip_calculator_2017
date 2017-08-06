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

    var tipAmounts:Array<Double> = [0.18, 0.20, 0.25]
    var currencies:Array<String> = ["en_US", "en_GB", "es_ES", "ja_JP"]

    var currency = ""

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

        calculateTip(Any.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController view will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(" ViewControllerview did disappear")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeTip(_ sender: Any) {
        print("changed tip amount")

        // Highlight new total
        if (totalLabel.text != "$0.00"){
            UIView.animate(withDuration: 0.6, animations: {
                self.totalViewContainer.backgroundColor = UIColor(red:0.28, green:0.57, blue:0.97, alpha:1.0)

            })
            UIView.animate(withDuration: 0.6, animations: {
                self.totalViewContainer.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
                
            })

            calculateTip(Any.self)
        }
    }


    @IBAction func calculateTip(_ sender: Any) {
//      calculate numerical amount of tip and total
        let bill = Double(billField.text!) ?? 0
        let selectedTipAmount = Double(tipAmounts[tipPercent.selectedSegmentIndex])
        let tip  = bill * selectedTipAmount
        let total = bill + tip


//      Set currency through Local
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: self.currency)
        formatter.numberStyle = .currency


//      Set tip and total with current currency
        if let formattedTipAmount = formatter.string(from: tip as NSNumber) {
            tipLabel.text = formattedTipAmount
        }

        if let formattedTotalAmount = formatter.string(from: total as NSNumber) {
            totalLabel.text = formattedTotalAmount
        }


//      Save bill to UserDefaults to be used for the next 10 min
        let currentTimeInMiliseconds = Date().timeIntervalSince1970

        defaults.set(billField.text, forKey: "lastBillAmount")
        defaults.set(currentTimeInMiliseconds, forKey: "lastBillTime")
        defaults.synchronize()
    }
}

