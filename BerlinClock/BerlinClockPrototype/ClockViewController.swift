//
//  ClockViewController.swift
//  BerlinClockPrototype
//
//  Created by Hugo Alonso on 22/03/2021.
//

import Foundation
import UIKit

open class Lamp: UIView {
    func turnOn() {
        DispatchQueue.main.async {
            self.backgroundColor = .black
        }
    }

    func turnOff() {
        DispatchQueue.main.async {
            self.backgroundColor = .black
        }
    }
}

final class YellowLamp: Lamp {

    override func turnOn()  {
        DispatchQueue.main.async {
            self.backgroundColor = .yellow
        }
    }

    override func turnOff() {
        DispatchQueue.main.async {
            self.backgroundColor = .darkGray
        }
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

    var ticker: Timer?

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        start()
    }

    func start() {
        var minute: Int = 0
        var hour: Int = 0
        ticker = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] timer in
            if self.seconds?.backgroundColor == .darkGray {
                self.seconds?.turnOn()
            } else {
                self.seconds?.turnOff()
            }
            if minute == 60 {
                hour = hour.advanced(by: 1)
                minute = 0
            }

            if hour == 24 {
                hour = 0
            }


            if singleMinuteRow.count > minute % 5 {
                self.singleMinuteRow?[minute % 5].turnOn()
            } else {
                self.turnCLockOff(views: self.singleMinuteRow)
            }

            if minute % 5 == 0 {
                self.turnCLockOff(views: self.singleMinuteRow)
            }

            if hour % 5 == 0 {
                self.turnCLockOff(views: self.singleHourRow)
            }

            if fiveMinuteRow.count > minute / 5 {
                self.fiveMinuteRow?[minute / 5].turnOn()
            } else {
                self.turnCLockOff(views: self.fiveMinuteRow)
            }

            if singleHourRow.count > hour % 5 {
                self.singleHourRow?[hour % 5].turnOn()
            } else {
                self.turnCLockOff(views: self.singleHourRow)
            }

            if fiveHourRow.count > hour / 5 {
                self.fiveHourRow?[hour / 5].turnOn()
            } else {
                self.turnCLockOff(views: self.fiveHourRow)
            }

            if minute == 0 {
                self.turnCLockOff(views: self.singleMinuteRow)
                self.turnCLockOff(views: self.fiveMinuteRow)
            }

            if hour == 0 {
                self.turnCLockOff(views: self.singleHourRow)
                self.turnCLockOff(views: self.fiveHourRow)
            }

            minute+=1
        }
        ticker?.fire()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        ticker?.invalidate()
    }
}
