//
//  LeftAlignedHorizontalCollectionViewFlowLayout.swift
//  SurfInternship
//
//  Created by Aleksandr on 10.02.2023.
//
//

import UIKit

final class LeftAlignedHorizontalCollectionViewFlowLayout: UICollectionViewFlowLayout {
   
   required override init() {super.init(); common()}
       required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); common()}
       
       private func common() {
           scrollDirection = .horizontal
           minimumLineSpacing = 12
           minimumInteritemSpacing = 0
           sectionInset.left = 16
       }
       
       override func layoutAttributesForElements(
                       in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
           
           guard let att = super.layoutAttributesForElements(in:rect) else {return []}
           
           let group = att.group(by: {$0.frame.origin.y})
           
           var x: CGFloat = sectionInset.left
           
           for attr in group {
               x = sectionInset.left
               for a in attr{
                   if a.representedElementCategory != .cell { continue }
                   a.frame.origin.x = x
                   x += a.frame.width + minimumInteritemSpacing
               }
           }
           return att
       }
}
