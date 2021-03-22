//
//  ClockViewController.swift
//  BerlinClockPrototype
//
//  Created by ***REMOVED*** on 22/03/2021.
//

import Foundation
import UIKit

open class Lamp: UIView {
    func turnOn() {
        backgroundColor = .black
    }

    func turnOff() {
        backgroundColor = .black
    }
}

final class YellowLamp: Lamp {

    override func turnOn()  {
        backgroundColor = .yellow
    }

    override func turnOff() {
        backgroundColor = .darkGray
    }
}

final class RedLamp: Lamp {
    override func turnOn() {
        backgroundColor = .red
    }

    override func turnOff() {
        backgroundColor = .darkGray
    }
}

final class ClockViewController: UIViewController {

    @IBOutlet weak var seconds: Lamp!

    @IBOutlet var fiveHourRow: [Lamp]!
    @IBOutlet var singleHourRow: [Lamp]!

    @IBOutlet var fiveMinuteRow: [Lamp]!
    @IBOutlet var singleMinuteRow: [Lamp]!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupUI()
    }

    private func roundCorners(views: [Lamp], cornerRadius: CGFloat) {
        views.forEach { (view) in
            view.layer.cornerRadius = cornerRadius
        }
    }

    private func setTransparency(views: [Lamp], alpha: CGFloat) {
        views.forEach { (view) in
            view.alpha = alpha
        }
    }

    private func turnCLockOff(views: [Lamp]) {
        views.forEach { (lamp) in
            lamp.turnOff()
        }
    }

    private func setupUI() {
        let hours: [Lamp] = fiveHourRow + singleHourRow
        let minutes: [Lamp] = fiveMinuteRow + singleMinuteRow
        let second: [Lamp] = [seconds]

        setTransparency(views: hours + minutes + second, alpha: 1)

        turnCLockOff(views: hours + minutes + second)

        roundCorners(
            views:  hours + minutes,
            cornerRadius: 10
        )
    }
}
