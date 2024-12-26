//
//  ViewController.swift
//  ExpenseMe
//
//  Created by Ashish on 16/12/24.
//

import UIKit
import CoreGraphics
protocol AddTransactionControllerDelegate: AnyObject {
    func didDismissAddTransactionController()
}
class ViewController: UIViewController, AddTransactionControllerDelegate {
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var MonthGraphView: CircularGraphView!
    
    @IBOutlet weak var TodayGraphView: CircularGraphView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabbar: UIView!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var TodayGraphPercentage: UILabel!
    @IBOutlet weak var DailyExpenseLabel: UILabel!
    @IBOutlet weak var MonthGraphPercentage: UILabel!
    @IBOutlet weak var MonthNameLabel: UILabel!
    
    @IBOutlet weak var MonthlyAmountLabel: UILabel!
    var counter=1
    func fetchitems(){
        do{
            let items=try context.fetch(StoredTransaction.fetchRequest())
            print(items[0].id)
            print("DAMN GILS")
        }
        catch{
            print("error occured")
        }
    }
    override func viewDidLoad() {
        
                super.viewDidLoad()
        ExpenseBrain.shared.migrateTransactionsToSetCategoryToNull()
        tableView.layer.cornerRadius=20
        tableView.dataSource=self
        tableView.delegate=self
        tabbar.layer.cornerRadius=30
        DailyExpenseLabel.adjustsFontSizeToFitWidth=true
        TodayGraphPercentage.adjustsFontSizeToFitWidth=true
        MonthlyAmountLabel.adjustsFontSizeToFitWidth=true
        MonthGraphPercentage.adjustsFontSizeToFitWidth=true
        let nib=UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.reloadData()
        updateTodayView()
        updateMonthView()
    }
    override func viewWillAppear(_ animated: Bool) {
    
        tableView.reloadData()
  //      updateTodayView()
    }
    override func viewDidAppear(_ animated: Bool) {
     ///   updateTodayView()
    }
    @IBAction func plusBtn(_ sender: Any) {
      //  showMyViewControllerInACustomizedSheet()
    }
    func showMyViewControllerInACustomizedSheet() {
        self.view.alpha=0.1
        let viewControllerToPresent = storyboard?.instantiateViewController(withIdentifier: "TransactionViewController") as! AddTransactionController
        viewControllerToPresent.delegate=self
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible=true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    func didDismissAddTransactionController() {
           self.view.alpha = 1.0
        self.tableView.reloadData()// Restore the alpha
        self.AmountLabel.text=String(ExpenseBrain.shared.getTotalAmountinAccount())
        updateTodayView()
        updateMonthView()
        tableView.reloadData()
       }
    
    @IBAction func showTransController(_ sender: Any) {
//        let uv=storyboard?.instantiateViewController(withIdentifier: "TransactionViewController") as! AddTransactionController
//        uv.delegate=self
//        present(uv, animated: true)
        showMyViewControllerInACustomizedSheet()
    }
    @IBAction func showSettings(_ sender: Any) {
        let uv=storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        present(uv, animated: true)
    }
    func updateMonthView()
    {
        let today=Date()
        MonthNameLabel.text=today.monthName()
        let Calendar=Calendar.current
        let components=Calendar.dateComponents([.month], from:today)
        let month=components.month!
        let t1=ExpenseBrain.shared.getTotalExpensesByMonth(in: month)
        let percentage=String(round((t1/10000) * 100))
        MonthGraphPercentage.text="\(percentage)%"
        MonthGraphView.setProgress(CGFloat(round(t1)), total: 10000)
        MonthlyAmountLabel.text="$\(String(t1))"
        AmountLabel.text="$ \(ExpenseBrain.shared.getTotalAmountinAccount())"
    }
    func  updateTodayView(){
        
        let progress=ExpenseBrain.shared.getAllExpensesToday()
        
        let total=ExpenseBrain.shared.getTotalAmountinAccount()
        TodayGraphView.setProgress(CGFloat(progress),total:5000)
        let roundedProgress=round(progress)
        DailyExpenseLabel.text="$\(roundedProgress)"

        let perecentage=String(round((progress/5000)*100))
        
        TodayGraphPercentage.text="\(perecentage)%"
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //return ExpenseBrain.shared.TransactionArrayMain.count
        return ExpenseBrain.shared.TransactionArrayMain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell=UITableViewCell()
//        cell.textLabel?.text=ExpenseBrain.shared.TransactionArrayMain[indexPath.row].title
//        return cell
        let cell=tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.titleLable.text=ExpenseBrain.shared.TransactionArrayMain[indexPath.row].title
        cell.timestamp.text=describeDate(ExpenseBrain.shared.TransactionArrayMain[indexPath.row].date)
        if ExpenseBrain.shared.TransactionArrayMain[indexPath.row].income{
            cell.AmountLabel.textColor=UIColor(r:50,g:168,b:82);            cell.AmountLabel.text="+\(ExpenseBrain.shared.TransactionArrayMain[indexPath.row].amount)"
        }
        else{
            cell.AmountLabel.text="-\(ExpenseBrain.shared.TransactionArrayMain[indexPath.row].amount)"
        }
        return cell
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id=ExpenseBrain.shared.TransactionArrayMain[indexPath.row].id
            ExpenseBrain.shared.deleteTransaction(id:id)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateMonthView()
            updateTodayView()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}


extension ViewController{

    func describeDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let today = Date()
        let todayComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: today)
        let inputComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let formatter = DateFormatter()
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else if date >= startOfWeek && date <= endOfWeek {
            formatter.dateFormat = "EEEE" // Full day name (e.g., "Monday")
            return formatter.string(from: date)
        } else if inputComponents.year == todayComponents.year {
            formatter.dateFormat = "dd MMMM" // Day and month (e.g., "22 December")
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "dd MMMM yyyy" // Day, month, and year (e.g., "22 December 2023")
            return formatter.string(from: date)
        }
    }
    
   

}

extension Date {
    func monthName() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMM")
            return df.string(from: self)
    }
}
