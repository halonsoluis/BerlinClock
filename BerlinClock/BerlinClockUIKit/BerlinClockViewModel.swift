//
//  BerlinClockViewModel.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import BerlinClock

final class BerlinClockViewModel {
    private let clock: BerlinClockTimeProvider
    var ticker: Timer?

    init(clock: BerlinClockTimeProvider) {
        self.clock = clock
    }

    @objc func updateTime(timer: Timer) {
        _ = clock.time(for: Date())
        presenter?.setLampsColor(colors: [])
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
