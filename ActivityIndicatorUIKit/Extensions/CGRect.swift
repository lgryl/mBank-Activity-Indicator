// Created 27/10/2020

import UIKit

extension CGRect {
    public var centerSquare: CGRect {
        let smallerDimension = min(size.width, size.height)
        return CGRect(
            x: center.x - smallerDimension / 2,
            y: center.y - smallerDimension / 2,
            width: smallerDimension,
            height: smallerDimension
        )
    }

    public var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
