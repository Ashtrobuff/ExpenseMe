////
////  ExpenseBrain.swift
////  ExpenseMe
////
////  Created by Ashish on 16/12/24.
////
//
import Foundation
import CoreData
import UIKit

struct Transaction {
    var id: UUID
    var title: String
    var amount: Float
    var desc: String
    var income: Bool
    var date: Date
    var category:String
    
    init(title: String, amount: Float, desc: String, income: Bool, date: Date,category:String) {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.desc = desc
        self.income = income
        self.date = date
        self.category=category
    }
}

enum TransactionProperties {
    case id, title, amount, desc, income, date,category
}
//class ExpenseBrain {
//    // Singleton instance
//    static let shared = ExpenseBrain()
//    
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//     var TransactionArrayMain: [Transaction] = []
//    private let calendar = Calendar.current
//
//    // Private initializer to enforce singleton
//    private init() {
//        loadTransactions()
//    }
//
//    // MARK: - CRUD Operations
//    
//    func addTransaction(new transaction: Transaction) {
//        TransactionArrayMain.append(transaction)
//        saveArrayToCoreData()
//    }
//
//    func updateTransaction(id: UUID, propertyName: TransactionProperties, value: Any) {
//        if let index = TransactionArrayMain.firstIndex(where: { $0.id == id }) {
//            var transaction = TransactionArrayMain[index]
//            
//            switch propertyName {
//            case .id:
//                if let value = value as? UUID { transaction.id = value }
//            case .title:
//                if let value = value as? String { transaction.title = value }
//            case .amount:
//                if let value = value as? Float { transaction.amount = value }
//            case .desc:
//                if let value = value as? String { transaction.desc = value }
//            case .income:
//                if let value = value as? Bool { transaction.income = value }
//            case .date:
//                if let value = value as? Date { transaction.date = value }
//            }
//            
//            TransactionArrayMain[index] = transaction
//            saveArrayToCoreData()
//        }
//    }
//
//    func deleteTransaction(id: UUID) {
//        if let index = TransactionArrayMain.firstIndex(where: { $0.id == id }) {
//            TransactionArrayMain.remove(at: index)
//            saveArrayToCoreData()
//        }
//    }
//    
//    func getTransactionArr() -> [Transaction] {
//        return TransactionArrayMain
//    }
//
//    func getTransactionsByMonth(in month: Int) -> [Transaction] {
//        return TransactionArrayMain.filter {
//            calendar.component(.month, from: $0.date) == month
//        }
//    }
//
//    func getTransactionsonDay(on date: Date) -> [Transaction] {
//        return TransactionArrayMain.filter {
//            calendar.isDate($0.date, inSameDayAs: date)
//        }
//    }
//
//    func getAllExpenses() -> [Transaction] {
//        return TransactionArrayMain.filter { !$0.income }
//    }
//
//    func getAllIncome() -> [Transaction] {
//        return TransactionArrayMain.filter { $0.income }
//    }
//
//    func getTotalAmountinAccount() -> Float {
//        return TransactionArrayMain.reduce(0) {
//            $0 + ($1.income ? $1.amount : 0)
//        }
//    }
//
//    func getAllExpensesToday() -> Float {
//        let today = Date()
//        return TransactionArrayMain.filter {
//            !$0.income && calendar.isDate($0.date, inSameDayAs: today)
//        }.reduce(0) { $0 + $1.amount }
//    }
//    
//    func getTotalExpensesByMonth(in month: Int) -> Float {
//        return TransactionArrayMain.filter { !$0.income && calendar.component(.month, from: $0.date) == month }
//            .reduce(0) { $0 + $1.amount }
//    }
//    
//    func calculateMonthlyExpenses() -> [Float] {
//        var monthlyExpenses = Array(repeating: Float(0), count: 12) // Initialize array with 12 zeros
//        let calendar = Calendar.current
//
//        for transaction in self.TransactionArrayMain {
//            if !transaction.income { // Check if it's an expense
//                let month = calendar.component(.month, from: transaction.date) - 1 // Get month (0-based index)
//                monthlyExpenses[month] += transaction.amount
//            }
//        }
//
//        return monthlyExpenses
//    }
//    func getYearlyAverageExpenses() -> Float {
//        return TransactionArrayMain.filter { !$0.income }
//            .reduce(0) { $0 + $1.amount } / Float(TransactionArrayMain.count)
//    }
//    func getDistinctMonths() -> Int {
//        let calendar = Calendar.current
//        var distinctMonths = Set<String>()
//        
//        for transaction in TransactionArrayMain {
//            let monthYear = calendar.dateComponents([.year, .month], from: transaction.date)
//            if let year = monthYear.year, let month = monthYear.month {
//                let monthKey = "\(year)-\(String(format: "%02d", month))" // Format as "YYYY-MM"
//                distinctMonths.insert(monthKey)
//            }
//        }
//        
//        return distinctMonths.count
//    }
//    // MARK: - Core Data Integration
//    
//    private func saveArrayToCoreData() {
//        // Delete existing data
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = StoredTransaction.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//        do {
//            try context.execute(deleteRequest)
//       //     try context.save()
//            
//            // Save current state of TransactionArrayMain
//            for transaction in TransactionArrayMain {
//                let entity = StoredTransaction(context: context)
//                print(entity.id)
//                entity.id = transaction.id
//                entity.title = transaction.title
//                entity.amount = transaction.amount
//                entity.desc = transaction.desc
//                entity.income = transaction.income
//                entity.date = transaction.date
//            }
//            try context.save()
//        } catch {
//            print("Failed to save array to Core Data: \(error)")
//        }
//    }
//    
//     func loadTransactions() {
//        let fetchRequest: NSFetchRequest<StoredTransaction> = StoredTransaction.fetchRequest()
//        do {
//            let entities = try context.fetch(fetchRequest)
//            TransactionArrayMain = entities.map {
//                Transaction(
//                    title: $0.title!,
//                    amount: $0.amount,
//                    desc: $0.desc!,
//                    income: $0.income,
//                    date: $0.date!
//                )
//            }
//            print("data stored successfully")
//        } catch {
//            print("Failed to fetch transactions: \(error)")
//        }
//    }
//}

class ExpenseBrain {
    // Singleton instance
    static let shared = ExpenseBrain()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var TransactionArrayMain: [Transaction] = []
    private let calendar = Calendar.current

    // Private initializer to enforce singleton
    private init() {
        migrateTransactionsToSetCategoryToNull()
        loadTransactions()
    }

    // MARK: - CRUD Operations
    
    func addTransaction(new transaction: Transaction) {
        TransactionArrayMain.append(transaction)
        saveArrayToCoreData()
    }

    func updateTransaction(id: UUID, propertyName: TransactionProperties, value: Any) {
        if let index = TransactionArrayMain.firstIndex(where: { $0.id == id }) {
            var transaction = TransactionArrayMain[index]

            switch propertyName {
            case .id:
                if let value = value as? UUID { transaction.id = value }
            case .title:
                if let value = value as? String { transaction.title = value }
            case .amount:
                if let value = value as? Float { transaction.amount = value }
            case .desc:
                if let value = value as? String { transaction.desc = value }
            case .income:
                if let value = value as? Bool { transaction.income = value }
            case .date:
                if let value = value as? Date { transaction.date = value }
            case .category:
                if let value = value as? String { transaction.category = value }
            }
            
            TransactionArrayMain[index] = transaction
            saveArrayToCoreData()
        }
    }

    func deleteTransaction(id: UUID) {
        if let index = TransactionArrayMain.firstIndex(where: { $0.id == id }) {
            TransactionArrayMain.remove(at: index)
            saveArrayToCoreData()
        }
    }
    
    func getTransactionArr() -> [Transaction] {
        return TransactionArrayMain
    }

    func getTransactionsByMonth(in month: Int) -> [Transaction] {
        return TransactionArrayMain.filter {
            calendar.component(.month, from: $0.date) == month
        }
    }

    func getTransactionsonDay(on date: Date) -> [Transaction] {
        return TransactionArrayMain.filter {
            calendar.isDate($0.date, inSameDayAs: date)
        }
    }

    func getAllExpenses() -> [Transaction] {
        return TransactionArrayMain.filter { !$0.income }
    }

    func getAllIncome() -> [Transaction] {
        return TransactionArrayMain.filter { $0.income }
    }

    func getTotalAmountinAccount() -> Float {
        return TransactionArrayMain.reduce(0) {
            $0 + ($1.income ? $1.amount : 0)
        }
    }

    func getAllExpensesToday() -> Float {
        let today = Date()
        return TransactionArrayMain.filter {
            !$0.income && calendar.isDate($0.date, inSameDayAs: today)
        }.reduce(0) { $0 + $1.amount }
    }
    
    func getTotalExpensesByMonth(in month: Int) -> Float {
        return TransactionArrayMain.filter { !$0.income && calendar.component(.month, from: $0.date) == month }
            .reduce(0) { $0 + $1.amount }
    }
    func getPastWeeksExpenses()->[Float]
  {
    var weeklyExpenses = Array(repeating: Float(0), count: 7) // Initialize array with 12 zeros
    let calendar = Calendar.current

    for transaction in self.TransactionArrayMain {
        if !transaction.income { // Check if it's an expense
            let week = calendar.component(.weekday, from: transaction.date) - 1 // Get month (0-based index)
            weeklyExpenses[week] += transaction.amount
        }
    }
      return weeklyExpenses
    }
    func calculateMonthlyExpenses() -> [Float] {
        var monthlyExpenses = Array(repeating: Float(0), count: 12) // Initialize array with 12 zeros
        let calendar = Calendar.current

        for transaction in self.TransactionArrayMain {
            if !transaction.income { // Check if it's an expense
                let month = calendar.component(.month, from: transaction.date) - 1 // Get month (0-based index)
                monthlyExpenses[month] += transaction.amount
            }
        }

        return monthlyExpenses
    }

    func getDistinctMonths() -> Int {
        let calendar = Calendar.current
        var distinctMonths = Set<String>()
        
        for transaction in TransactionArrayMain {
            let monthYear = calendar.dateComponents([.year, .month], from: transaction.date)
            if let year = monthYear.year, let month = monthYear.month {
                let monthKey = "\(year)-\(String(format: "%02d", month))" // Format as "YYYY-MM"
                distinctMonths.insert(monthKey)
            }
        }
        
        return distinctMonths.count
    }
    
    func migrateTransactionsToSetCategoryToNull() {
           let fetchRequest: NSFetchRequest<StoredTransaction> = StoredTransaction.fetchRequest()
           
           do {
               // Fetch all transactions from Core Data
               let transactions = try context.fetch(fetchRequest)
               
               for transaction in transactions {
                   transaction.category = "null" // Set category to null
               }
               
               // Save the changes
               try context.save()
               print("Migration completed: All transaction categories set to null.")
           } catch {
               print("Migration failed: \(error)")
           }
       }
    // MARK: - Core Data Integration
    
    private func saveArrayToCoreData() {
        // Delete existing data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = StoredTransaction.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            
            // Save current state of TransactionArrayMain
            for transaction in TransactionArrayMain {
                let entity = StoredTransaction(context: context)
                entity.id = transaction.id
                entity.title = transaction.title
                entity.amount = transaction.amount
                entity.desc = transaction.desc
                entity.income = transaction.income
                entity.date = transaction.date
                entity.category = transaction.category // Save the category
            }
            try context.save()
        } catch {
            print("Failed to save array to Core Data: \(error)")
        }
    }
    
    func loadTransactions() {
        let fetchRequest: NSFetchRequest<StoredTransaction> = StoredTransaction.fetchRequest()
        do {
            let entities = try context.fetch(fetchRequest)
            TransactionArrayMain = entities.map {
                Transaction(
                    title: $0.title!,
                    amount: $0.amount,
                    desc: $0.desc!,
                    income: $0.income,
                    date: $0.date!,
                    category: $0.category! // Load the category
                )
            }
            print("data loaded successfully")
        } catch {
            print("Failed to fetch transactions: \(error)")
        }
    }
}
