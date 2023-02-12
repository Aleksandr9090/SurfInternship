//
//  DataManager.swift
//  SurfInternship
//
//  Created by Aleksandr on 06.02.2023.
//

struct Specialty {
    let title: String
    let collectionViewIndex: Int
    var isSelected: Bool
    
    init(title: String, collectionViewIndex: Int, condition: Bool = false) {
        self.title = title
        self.collectionViewIndex = collectionViewIndex
        self.isSelected = condition
    }
    
    static var specialtiesCollection: [Specialty] = [
        Specialty(title: "IOS", collectionViewIndex: 0),
        Specialty(title: "Android", collectionViewIndex: 0),
        Specialty(title: "Design", collectionViewIndex: 0),
        Specialty(title: "Flutter", collectionViewIndex: 0),
        Specialty(title: "QA", collectionViewIndex: 0),
        Specialty(title: "Backend", collectionViewIndex: 0),
        Specialty(title: "Frontend", collectionViewIndex: 0),
        Specialty(title: "Retail", collectionViewIndex: 0),
        Specialty(title: "Media", collectionViewIndex: 0),
        Specialty(title: "FinTech", collectionViewIndex: 0),
        Specialty(title: "IOS", collectionViewIndex: 1),
        Specialty(title: "Android", collectionViewIndex: 1),
        Specialty(title: "Design", collectionViewIndex: 1),
        Specialty(title: "Flutter", collectionViewIndex: 1),
        Specialty(title: "QA", collectionViewIndex: 1),
        Specialty(title: "Backend", collectionViewIndex: 1),
        Specialty(title: "Frontend", collectionViewIndex: 1),
        Specialty(title: "Retail", collectionViewIndex: 1),
        Specialty(title: "Media", collectionViewIndex: 1),
        Specialty(title: "FinTech", collectionViewIndex: 1),
    ]
}
