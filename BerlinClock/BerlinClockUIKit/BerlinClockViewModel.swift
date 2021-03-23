//
//  BerlinClockViewModel.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import BerlinClock

struct RGBA: Equatable {
    let red: Float
    let green: Float
    let blue: Float
    let alpha: Float
}

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

        let colors: [RGBA] = formattedTime.compactMap {
            switch $0 {
            case "Y": return RGBA(red: 0, green: 1, blue: 1, alpha: 1)
            case "R": return RGBA(red: 1, green: 0, blue: 0, alpha: 1)
            case "0": return RGBA(red: 0, green: 0, blue: 0, alpha: 0.65)
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
