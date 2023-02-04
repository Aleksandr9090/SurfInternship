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
