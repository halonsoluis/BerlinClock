//
//  ClockViewController.swift
//  BerlinClockPrototype
//
//  Created by Hugo Alonso on 22/03/2021.
//

import Foundation
import UIKit

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
