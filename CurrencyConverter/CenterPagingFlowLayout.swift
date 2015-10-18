//
//  CenterPagingFlowLayout.swift
//  CurrencyConverter
//
//  Created by Carla Alexander on 2015-10-19.
//  Copyright © 2015 Carla. All rights reserved.
//

import UIKit

class CenterPagingFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView, attributes = self.layoutAttributesForElementsInRect(collectionView.bounds) where !attributes.isEmpty else {
            //pass through
            return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
        }
        
        let collectionViewBounds = collectionView.bounds
        let centerHorizontalOffsetX = proposedContentOffset.x + CGRectGetWidth(collectionViewBounds) / 2
        var providedAttributes: UICollectionViewLayoutAttributes = attributes.first!
        
        for attribute in attributes {
            let originalCenterOffset = attribute.center.x - centerHorizontalOffsetX
            let providedCenterOffset = providedAttributes.center.x - centerHorizontalOffsetX
            
            if fabsf(Float(originalCenterOffset)) < fabsf(Float(providedCenterOffset)) {
                providedAttributes = attribute
            }
        }
        
        if proposedContentOffset.x == -(collectionView.contentInset.left) {
            return proposedContentOffset
        }

        return CGPoint(x: floor(providedAttributes.center.x - CGRectGetWidth(collectionViewBounds) / 2), y: proposedContentOffset.y)
    }
}