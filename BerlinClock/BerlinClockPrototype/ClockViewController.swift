//
//  ClockViewController.swift
//  BerlinClockPrototype
//
//  Created by ***REMOVED*** on 22/03/2021.
//

import Foundation
import UIKit

protocol Lamp: UIView {
    var onColor: UIColor { get }
    var offColor: UIColor { get }
}

extension Lamp {

    func turnOn() {
        backgroundColor = onColor
    }

    func turnOff() {
        backgroundColor = offColor
    }
}

final class YellowLamp: UIView, Lamp {
    let onColor: UIColor = .yellow
    let offColor: UIColor = .darkGray
}

final class RedLamp: UIView, Lamp {
    let onColor: UIColor = .red
    let offColor: UIColor = .darkGray
}

final class ClockViewController: UIViewController {

    @IBOutlet weak var seconds: UIView!

    @IBOutlet var fiveHourRow: [UIView]!
    @IBOutlet var singleHourRow: [UIView]!

    @IBOutlet var fiveMinuteRow: [UIView]!
    @IBOutlet var singleMinuteRow: [UIView]!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupUI()
    }

    private func roundCorners(views: [UIView], cornerRadius: CGFloat) {
        views.forEach { (view) in
            view.layer.cornerRadius = cornerRadius
        }
    }

    private func setupUI() {
        roundCorners(
            views: fiveHourRow + singleHourRow + fiveMinuteRow + singleMinuteRow,
            cornerRadius: 10
        )
    }
}
