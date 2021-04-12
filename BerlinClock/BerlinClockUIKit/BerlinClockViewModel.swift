//
//  BerlinClockViewModel.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import CoreGraphics
import BerlinClock

public final class BerlinClockViewModel {
    private let clock: BerlinClockTimeProvider
    private let dateProvider: () -> Date
    private let colorMapper: (Character) -> CGColor
    private var tickerFactory: TickerFactory
    private var ticker: Timer?

    public var presenter: ClockPresenter?

    public init(clock: BerlinClockTimeProvider,
                dateProvider: @escaping () -> Date = { Date() },
                colorMapper: @escaping (Character) -> CGColor,
                tickerFactory: TickerFactory) {
        self.clock = clock
        self.dateProvider = dateProvider
        self.colorMapper = colorMapper
        self.tickerFactory = tickerFactory
    }

    func updateTime() {
        let colors = clock
            .time(for: dateProvider())
            .map(colorMapper)

        presenter?.setLampsColor(colors: colors)
    }
}

extension BerlinClockViewModel: BerlinClockInteractor {
    public func start() {
        ticker = tickerFactory.execute(block: updateTime, every: 1)
    }

    public func stop() {
        if let ticker = ticker {
            tickerFactory.stop(ticker: ticker)
        }
        ticker = nil
    }
}
