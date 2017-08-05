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
        tipPercent.selectedSegmentIndex = defualtTipPercentageIndex

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

    @IBAction func calculateTip(_ sender: Any) {
        let tipAmounts = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        let selectedTipAmount = Double(tipAmounts[tipPercent.selectedSegmentIndex])
        let tip  = bill * selectedTipAmount
        let total = bill + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

    }
}

