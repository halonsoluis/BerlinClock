//
//  BerlinClockViewController.swift
//  BerlinClockUIKit
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import UIKit
import BerlinClock

public protocol ClockPresenter: class {
    func setLampsColor(colors: [RGBA])
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
    public func setLampsColor(colors: [RGBA]) {

        guard let lamps = lamps else {
            return
        }

        let uiColors = colors.map { $0.uiColor() }

        colorize(colors: uiColors, lamps: lamps)
    }

    private func colorize(colors: [UIColor], lamps: [UIView]) {
        zip(colors, lamps).forEach { (color, lamp) in
            lamp.backgroundColor = color
        }
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

extension RGBA {
    func uiColor() -> UIColor {
        UIColor.init(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: CGFloat(alpha)
        )
    }
}
