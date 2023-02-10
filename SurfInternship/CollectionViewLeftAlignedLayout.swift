//
//  CollectionViewLeftAlignedLayout.swift
//  SurfInternship
//
//  Created by Aleksandr on 10.02.2023.
//

//import UIKit
//
//final class CollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
//    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributes = super.layoutAttributesForElements(in: rect)
//
//        var leftMargin: CGFloat = 16
//        var lastItemWidth: CGFloat = 0
//        attributes?.forEach { layoutAttribute in
//            layoutAttribute.frame.origin.x = 10
//            lastItemWidth += layoutAttribute.frame.width
//
//            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
//            maxY = max(layoutAttribute.frame.maxY , maxY)
//        }
//        return attributes
//    }
//}
