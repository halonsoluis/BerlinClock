//
//  BerlinClockViewModel.swift
//  BerlinClockUIKit
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import Foundation
import BerlinClock
import UIKit

final class BerlinClockViewModel {
    private let clock: BerlinClockTimeProvider
    private let dateProvider: () -> Date

    weak var presenter: ClockPresenter?
    var ticker: Timer?

    init(clock: BerlinClockTimeProvider, dateProvider: @escaping () -> Date = { Date() }) {
        self.clock = clock
        self.dateProvider = dateProvider
    }

    @objc func updateTime(timer: Timer) {
        let formattedTime = clock.time(for: dateProvider())

        let colors: [UIColor] = formattedTime.compactMap {
            switch $0 {
            case "Y": return UIColor.yellow
            case "R": return UIColor.red
            case "0": return UIColor.darkGray
            default: return nil
            }
        }

        presenter?.setLampsColor(colors: colors)
    }
}

extension BerlinClockViewModel: BerlinClockInteractor {
    func start() {
        ticker = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTime)
    }

    func stop() {
        ticker?.invalidate()
    }
}
