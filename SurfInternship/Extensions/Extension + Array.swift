//
//  Extension + Array.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return (index >= 0 && index < endIndex) ? self[index] : nil
    }
}

extension Array {
   func group<T: Hashable>(by key: (_ element: Element) -> T) -> [[Element]] {
       var categories: [T: [Element]] = [:]
       var groups = [[Element]]()
       for element in self {
           let key = key(element)
           if case nil = categories[key]?.append(element) {
               categories[key] = [element]
           }
       }
       categories.keys.forEach { key in
           if let group = categories[key] {
               groups.append(group)
           }
       }
       return groups
   }
}
