// Created 30/10/2020

import UIKit

extension CALayer {
    public func addSublayers(_ sublayers: [CALayer]) {
        for layer in sublayers {
            addSublayer(layer)
        }
    }
}
