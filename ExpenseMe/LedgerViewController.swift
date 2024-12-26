//
//  LedgerViewController.swift
//  ExpenseMe
//
//  Created by Ashish on 22/12/24.
//

import UIKit
class LedgerViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.dataSource=self
        tableView.delegate=self
        tableView.layer.cornerRadius=20
  
    }
}
////  TABL VIEW METHODS
//extension LedgerViewController: UITableViewDataSource,UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ExpenseBrain.shared.TransactionArrayMain.count
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return ExpenseBrain.shared.getDistinctMonths()
//    }
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        var arr:[String]=[]
//        for i in 1...12
//        {
//            arr.append("\(i)")
//        }
//        return arr
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let index=ExpenseBrain.shared.TransactionArrayMain[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
//        cell.AmountLabel.text="\(index.amount)"
//        cell.titleLable.text="\(index.title)"
//        let timestamp=describeDate(index.date)
//        cell.timestamp.text="\(timestamp)"
//        
//        if (index.income)
//        {
//            cell.AmountLabel.textColor=UIColor.green
//        }
//        
//        return cell
//    }
//}
extension LedgerViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Group transactions by month
    var groupedTransactions: [String: [Transaction]] {
        let calendar = Calendar.current
        var groups = [String: [Transaction]]()
        
        for transaction in ExpenseBrain.shared.TransactionArrayMain {
            let monthYear = calendar.dateComponents([.year, .month], from: transaction.date)
            if let year = monthYear.year, let month = monthYear.month {
                let monthKey = "\(year)-\(String(format: "%02d", month))" // Format as "YYYY-MM"
                if groups[monthKey] != nil {
                    groups[monthKey]?.append(transaction)
                } else {
                    groups[monthKey] = [transaction]
                }
            }
        }
        
        return groups
    }
    
    // Number of sections (distinct months)
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedTransactions.keys.count
    }
    
    // Return the section titles (distinct months)
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedKeys = groupedTransactions.keys.sorted()
        return sortedKeys[section]
    }
    
    // Number of rows in each section (transactions for that month)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedKeys = groupedTransactions.keys.sorted()
        let monthKey = sortedKeys[section]
        return groupedTransactions[monthKey]?.count ?? 0
    }
    
    // Create the cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sortedKeys = groupedTransactions.keys.sorted()
        let monthKey = sortedKeys[indexPath.section]
        let transaction = groupedTransactions[monthKey]?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        if let transaction = transaction {
            cell.AmountLabel.text = "\(transaction.amount)"
            cell.titleLable.text = transaction.title
            let timestamp = describeDate(transaction.date)
            cell.timestamp.text = timestamp
            
            if transaction.income {
                cell.AmountLabel.textColor = UIColor.green
            }
        }
        
        return cell
    }

    // Section index titles (optional)
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        let sortedKeys = groupedTransactions.keys.sorted()
//        return sortedKeys
//    }
}

/// FETCHING DATA

extension LedgerViewController
{
    
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
