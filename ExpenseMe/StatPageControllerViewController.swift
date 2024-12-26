//
//  StatPageControllerViewController.swift
//  ExpenseMe
//
//  Created by Ashish on 22/12/24.
//

import UIKit

class StatPageViewController: UIViewController {

    @IBOutlet weak var yearGraphView: CustomGraphView!
    @IBOutlet weak var weeklyGraph: CustomGraphView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ReloadGraph()
        // Do any additional setup after loading the view.
        ReloadWeeklyGraph()
    }
    
    func ReloadGraph()
    {
        yearGraphView.plotPoints=ExpenseBrain.shared.calculateMonthlyExpenses()
        
       
    }
    @IBAction func showAverage(_ sender: Any) {
        
    }
    func ReloadWeeklyGraph()
    {
        weeklyGraph.plotPoints=ExpenseBrain.shared.getPastWeeksExpenses()
        weeklyGraph.uprange=6
    }
}
