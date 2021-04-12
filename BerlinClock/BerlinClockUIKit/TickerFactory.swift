//
//  TickerFactory.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 12/04/2021.
//

import Foundation

public protocol TickerFactory {
    func execute(
        block: @escaping () -> Void,
        every interval: TimeInterval
    ) -> Timer

    func stop(ticker: Timer)
}

public struct TickerFactoryImplementation: TickerFactory {
    public init() {}

    public func execute(block: @escaping () -> Void, every interval: TimeInterval = 1) -> Timer {
        return Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: true,
            block: { _ in
                block()
            }
        )
    }

    public func stop(ticker: Timer) {
        ticker.invalidate()
    }
}
