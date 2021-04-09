//
//  BerlinClockViewController.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import UIKit
import BerlinClock

public protocol ClockPresenter: class {
    func setLampsColor(colors: [CGColor])
}

public final class BerlinClockViewController: UIViewController {
    private var interactor: BerlinClockInteractor?
    @IBOutlet var lamps: [UIView]? = Array(repeating: UIView(), count: 24)

    public func connect(interactor: BerlinClockInteractor) {
        self.interactor = interactor
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor?.start()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        interactor?.stop()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        style()
    }
}

extension BerlinClockViewController: ClockPresenter {
    public func setLampsColor(colors: [CGColor]) {

        guard let lamps = lamps else {
            return
        }

        let uiColors = colors.map(UIColor.init)

        colorize(colors: uiColors, lamps: lamps)
    }

    private func colorize(colors: [UIColor], lamps: [UIView]) {
        zip(colors, lamps).forEach(generateGradient)
    }

    private func generateGradient(for color: UIColor, on view: UIView) {
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradient = CAGradientLayer()
        gradient.type = .radial
        gradient.colors = [ UIColor.white.withAlphaComponent(0.9).cgColor, color.cgColor]
        gradient.locations = [ 0, 1 ]
        gradient.opacity = 1

        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        gradient.frame = view.bounds

        view.layer.insertSublayer(gradient, at: 0)
        view.layoutIfNeeded()
        view.clipsToBounds = true
    }
}

extension BerlinClockViewController {
    private func style() {
        guard let allButSeconds: ArraySlice<UIView> = lamps?.dropFirst() else {
            return
        }
        roundCorners(views: Array(allButSeconds), cornerRadius: 10)
    }

    private func roundCorners(views: [UIView], cornerRadius: CGFloat) {
        views.forEach { (view) in
            view.layer.cornerRadius = cornerRadius
        }
    }
}
