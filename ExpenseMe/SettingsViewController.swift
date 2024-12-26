//
//  SettingsViewController.swift
//  ExpenseMe
//
//  Created by Ashish on 18/12/24.
//
import Foundation
import UIKit
class SettingsViewController:UIViewController
{
    @IBOutlet weak var DailyLimitField: UITextField!
    
    @IBOutlet weak var MonthlyLimitField: UITextField!
    
    @IBOutlet weak var BalanceField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
   
    @IBAction func DLStepper(_ sender: UIStepper) {
        DailyLimitField.text=String(sender.value)
    }
    
    @IBAction func MLStepper(_ sender: UIStepper) {
        MonthlyLimitField.text=String(sender.value)
    }
    
    @IBAction func BalanceStepper(_ sender: UIStepper) {
        BalanceField.text=String(sender.value)
    }
    
}
