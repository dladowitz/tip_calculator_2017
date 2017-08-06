//
//  SettingsViewController.swift
//  tip_calculator
//
//  Created by david ladowitz on 8/5/17.
//  Copyright © 2017 LittleCatLabs. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var currencyControl: UISegmentedControl!

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        print("triggering SettingsViewController viewDidLoad")

        let defualtTipPercentageIndex = defaults.integer(forKey: "defaultTipPercentageIndex")
        tipControl.selectedSegmentIndex = defualtTipPercentageIndex

        let currencyIndex = defaults.integer(forKey: "currencyIndex")
        currencyControl.selectedSegmentIndex = currencyIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeValue(_ sender: Any) {
        let defaultTipPercentageIndex = tipControl.selectedSegmentIndex

        defaults.set(defaultTipPercentageIndex, forKey: "defaultTipPercentageIndex")
        defaults.synchronize()
    }

    @IBAction func currencyChange(_ sender: Any) {
        let currencyIndex = currencyControl.selectedSegmentIndex

        defaults.set(currencyIndex, forKey: "currencyIndex")
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
