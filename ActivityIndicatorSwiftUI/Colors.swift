// Created 31/10/2020

import SwiftUI

public struct Colors {
    public static let `default` = ["Green", "Blue", "Red1", "Orange", "Black", "Red2"].compactMap {
        Color($0, bundle: Bundle(identifier: "pl.lgryl.ActivityIndicatorSwiftUI"))
    }
}
