// Created 03/11/2020

import UIKit

public struct Colors {
    public static let `default` = ["Green", "Blue", "Red1", "Orange", "Black", "Red2"].compactMap {
        UIColor(named: $0, in: Bundle(identifier: "pl.lgryl.ActivityIndicatorUIKit"), compatibleWith: nil)
    }
}
