// Created 31/10/2020

import SwiftUI

public struct ActivityIndicatorView: View {
    private static let fullCycleTime: TimeInterval = 4

    @State private var animate = false
    private let colors: [Color]

    public init(colors: [Color] = Colors.default) {
        self.colors = colors
    }

    public var body: some View {
        GeometryReader { outerGeometry in
            GeometryReader { geometry in
                ZStack {
                    ForEach(0 ..< colors.count) { index in
                        Circle()
                            .trim(from: pathStart(for: index), to: 0.6)
                            .stroke(colors[index], style: StrokeStyle(lineWidth: lineWidth(for: geometry.size), lineCap: .round))
                            .rotationEffect(.degrees(animate ? 360 : 0))
                            .animation(Animation.linear(duration: animationDuration(index: index)).repeatForever(autoreverses: false), value: Angle.degrees(animate ? 360 : 0))
                            .frame(width: dimension(index: index, size: geometry.size), height: dimension(index: index, size: geometry.size))
                    }
                }
            }
            .padding(lineWidth(for: outerGeometry.size) / 2)
            .onAppear {
                animate = true
            }
        }
    }

    private func pathStart(for index: Int) -> CGFloat {
        0.1 + CGFloat(index) * 0.05
    }

    private func lineWidth(for size: CGSize) -> CGFloat {
        min(size.width, size.height) / 40
    }

    private func animationDuration(index: Int) -> Double {
        return Self.fullCycleTime / (Double(colors.count) - Double(index))
    }

    private func dimension(index: Int, size: CGSize) -> CGFloat {
        min(size.width, size.height) * (1 - CGFloat(index) * 0.07)
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView().previewLayout(.fixed(width: 200, height: 200))
    }
}
