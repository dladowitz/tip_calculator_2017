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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        calculateTip(Any.self)
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

