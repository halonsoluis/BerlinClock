//
//  BerlinClockViewController.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import UIKit
import BerlinClock

protocol ClockPresenter: class {
    func setLampsColor(colors: [RGBA])
}

final class BerlinClockViewController: UIViewController {
    private var interactor: BerlinClockInteractor?
    var lamps: [UIView]?

    convenience init(interactor: BerlinClockInteractor) {
        self.init()
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        lamps = Array(repeating: UIView(), count: 24)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor?.start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        interactor?.stop()
    }
}

extension BerlinClockViewController: ClockPresenter {
    func setLampsColor(colors: [RGBA]) {

        guard let lamps = lamps else {
            return
        }

        let uiColors = colors.map { $0.uiColor() }

        zip(uiColors, lamps).forEach { (color, lamp) in
            lamp.backgroundColor = color
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

