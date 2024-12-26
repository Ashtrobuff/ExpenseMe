//
//  AddTransactionController.swift
//  ExpenseMe
//
//  Created by Ashish on 17/12/24.
//

import Foundation
import UIKit

class AddTransactionController:UIViewController
{
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var AmountField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var CateggoryField: UITextField!
    @IBOutlet weak var catButton: UIButton!
    
    @IBOutlet weak var dropDownButton: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white
        preferredContentSize = CGSize(width: view.bounds.width, height: 400)
        catButton.menu=UIMenu(title:"select a category",children: createCats())
        catButton.showsMenuAsPrimaryAction=true
    }
    weak var delegate: AddTransactionControllerDelegate?

     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         if isBeingDismissed {
             delegate?.didDismissAddTransactionController()
         }
         print("dismissed")
     }
   func get_ts_state()->Bool
    {
        return typeSelector.selectedSegmentIndex==1
    }
    @IBAction func AddTransaction(_ sender: Any) {
        print("aadding transaction")
        if (titleField.text=="" || AmountField.text=="" || CateggoryField.text=="")
        {
            let alert=UIAlertController(title: "enter correct details", message: "One of the values are missing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{_ in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: false)
            return
        }
        let transaction = Transaction(title: titleField.text!, amount: Float(Double(AmountField.text!)!), desc: "DESC",income:get_ts_state(),date: datePicker.date,category:CateggoryField.text!)
        ExpenseBrain.shared.addTransaction(new: transaction)
        print(ExpenseBrain.shared.TransactionArrayMain.count)
    }
    func createCats() -> [UIAction] {
            var cats = ["Food", "Transport", "Clothing", "Entertainment", "Bills", "Other"]
            var actions: [UIAction] = []
            
            for cat in cats {
                let action = UIAction(title: cat, handler: { _ in
                    self.CateggoryField.text = cat // Update the category field with selected category
                })
                actions.append(action)
            }
            
            return actions
        }
}
