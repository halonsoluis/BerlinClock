//
//  BerlinClockViewModel.swift
//  BerlinClockUIKit
//
//  Created by ---- ------ on 23/03/2021.
//

import Foundation
import CoreGraphics
import BerlinClock

public final class BerlinClockViewModel {
    private let clock: BerlinClockTimeProvider
    private let dateProvider: () -> Date
    private let colorMapper: (Character) -> CGColor

    public var presenter: ClockPresenter?
    var ticker: Timer?

    public init(clock: BerlinClockTimeProvider, dateProvider: @escaping () -> Date = { Date() }, colorMapper: @escaping (Character) -> CGColor) {
        self.clock = clock
        self.dateProvider = dateProvider
        self.colorMapper = colorMapper
    }

    @objc func updateTime(timer: Timer) {

        let colors = clock.time(for: dateProvider())
            .map(colorMapper)

        presenter?.setLampsColor(colors: colors)
    }
}

extension BerlinClockViewModel: BerlinClockInteractor {
    public func start() {
        ticker = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTime)
    }

    public func stop() {
        ticker?.invalidate()
    }
}
