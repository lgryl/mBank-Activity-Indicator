// Created 27/10/2020

import UIKit

public final class ActivityIndicatorView: UIView {
    private static let fullCycleTime: TimeInterval = 4
    private static let animationKey = "transform.rotation.z"

    private var arcLayers: [CAShapeLayer] = []
    private let colors: [UIColor]

    public init(colors: [UIColor] = Colors.default) {
        self.colors = colors
        super.init(frame: .zero)
        setup()
    }

    public required init?(coder: NSCoder) {
        self.colors = Colors.default
        super.init(coder: coder)
        setup()
    }

    public init(frame: CGRect, colors: [UIColor]) {
        self.colors = colors
        super.init(frame: frame)
    }

    public override init(frame: CGRect) {
        self.colors = Colors.default
        super.init(frame: frame)
        setup()
    }

    public override func didMoveToSuperview() {
        guard let _ = superview else { return }
        startAnimation()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        arcLayers.enumerated().forEach { (index, layer) in
            update(arcLayer: layer, index: index)
        }
    }
}

private extension ActivityIndicatorView {
    func setup() {
        registerForNotification()
        setupView()
    }

    func startAnimation() {
        arcLayers.enumerated().forEach { (index, layer) in
            let animation = createRotationAnimation(for: index)
            layer.add(animation, forKey: Self.animationKey)
        }
    }

    func createRotationAnimation(for index: Int) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: Self.animationKey)
        animation.duration = Self.fullCycleTime / (Double(arcLayers.count) - Double(index))
        animation.byValue = Double.pi * 2
        animation.repeatCount = .greatestFiniteMagnitude

        return animation
    }

    func setupView() {
        arcLayers = Colors.default.enumerated().map { (index, color) in
            let layer = createArcLayer(index: index)
            return layer
        }
        layer.addSublayers(arcLayers)
    }

    func createArcLayer(index: Int) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.strokeColor = Colors.default[index].cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeStart = 0.1 + CGFloat(index) * 0.05
        layer.strokeEnd = 0.6
        layer.lineCap = .round

        return layer
    }

    func update(arcLayer: CAShapeLayer, index: Int) {
        let centerSquare = bounds.centerSquare
        let inset = centerSquare.size.width * CGFloat(index) * 0.035
        let frame = centerSquare.insetBy(dx: inset, dy: inset)

        arcLayer.frame = frame
        arcLayer.path = CGPath(ellipseIn: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), transform: nil)

        arcLayer.lineWidth = centerSquare.size.width / 40
    }
}

private extension ActivityIndicatorView {
    func registerForNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    @objc func applicationWillEnterForeground() {
        startAnimation()
    }
}
