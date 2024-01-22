import UIKit

public extension UIView {
    func setAnchor(
        top: NSLayoutYAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        leading: NSLayoutXAxisAnchor? = nil,
        paddingLeading: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil,
        paddingBottom: CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil,
        paddingTrailing: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }

        if let bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }

        if let width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func setTop(anchor: NSLayoutYAxisAnchor, constant: CGFloat) {
        self.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func setLeading(anchor: NSLayoutXAxisAnchor, constant: CGFloat) {
        self.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func setBottom(anchor: NSLayoutYAxisAnchor, constant: CGFloat) {
        self.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func setTrailing(anchor: NSLayoutXAxisAnchor, constant: CGFloat) {
        self.trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func setCenter(view: UIView, offset: CGPoint) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.x).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.y).isActive = true
    }

    func setCenterX(
        view: UIView,
        topAnchor: NSLayoutYAxisAnchor? = nil,
        paddingTop: CGFloat = 0
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        if let topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop).isActive = true
        }
    }

    func setCenterY(
        view: UIView,
        constant: CGFloat = 0
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }

    func setDimensions(height: CGFloat, width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func setHeight(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func setWidth(_ width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func fillSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let view = self.superview else { return }
        self.setAnchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
    }
}
