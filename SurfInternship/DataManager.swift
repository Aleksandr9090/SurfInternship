//
//  DataManager.swift
//  SurfInternship
//
//  Created by Aleksandr on 06.02.2023.
//

class DataManager {
    static let shared = DataManager()
    
    let specialties = [
        "IOS",
        "Android",
        "Design",
        "Flutter",
        "Backend",
        "Frontend",
        "Retail",
        "Media",
        "M-commerce",
        "FinTech",
    ]
       
    private init() {}
}
