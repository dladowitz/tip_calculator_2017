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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        print("ViewController view viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController view will appear")

        let defaults = UserDefaults.standard
        let defualtTipPercentageIndex = defaults.integer(forKey: "defaultTipPercentageIndex")
        let lastBillTime = defaults.integer(forKey: "lastBillTime")
        let currentTimeInMiliseconds = Int(Date().timeIntervalSince1970)

        tipPercent.selectedSegmentIndex = defualtTipPercentageIndex

//        Use the last bill amount if it was set less than 10 minutes ago
        print("Last Bill Time: ", lastBillTime)
        print("Current Time:   ", currentTimeInMiliseconds)
        print("Differance:     ", (currentTimeInMiliseconds - lastBillTime))
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


    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
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

    @IBAction func finishEditingBillField(_ sender: Any) {
        print("finish editing bill field")
    }

    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let selectedTipAmount = Double(tipAmounts[tipPercent.selectedSegmentIndex])
        let tip  = bill * selectedTipAmount
        let total = bill + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

//        Save bill to UserDefaults
        let currentTimeInMiliseconds = Date().timeIntervalSince1970
        let defaults = UserDefaults.standard

        defaults.set(billField.text, forKey: "lastBillAmount")
        defaults.set(currentTimeInMiliseconds, forKey: "lastBillTime")
        defaults.synchronize()

    }
}

