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

    override func viewDidLoad() {
        super.viewDidLoad()

        print("triggering SettingsViewController viewDidLoad")

        let defaults = UserDefaults.standard
        let defualtTipPercentageIndex = defaults.integer(forKey: "defaultTipPercentageIndex")
        tipControl.selectedSegmentIndex = defualtTipPercentageIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeValue(_ sender: Any) {
        let defaultTipPercentageIndex = tipControl.selectedSegmentIndex
        let defaults = UserDefaults.standard

        defaults.set(defaultTipPercentageIndex, forKey: "defaultTipPercentageIndex")
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
