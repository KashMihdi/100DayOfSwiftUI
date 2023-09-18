//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Kasharin Mikhail on 15.09.2023.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            content(item)
        }
    }
    
    init(
        sortDescriptor: [NSSortDescriptor],
        filterKey: String,
        filterValue: String,
        predicate: PredicateFilter,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptor, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
            self.content = content
        }
}

enum PredicateFilter: String {
    case beginWith = "BEGINSWITH"
}
