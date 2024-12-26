//
//  StoredTransaction+CoreDataProperties.swift
//  ExpenseMe
//
//  Created by Ashish on 21/12/24.
//
//

import Foundation
import CoreData


extension StoredTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredTransaction> {
        return NSFetchRequest<StoredTransaction>(entityName: "StoredTransaction")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Float
    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var income: Bool
    @NSManaged public var date: Date?
    @NSManaged public var category:String?

}

extension StoredTransaction : Identifiable {
}
