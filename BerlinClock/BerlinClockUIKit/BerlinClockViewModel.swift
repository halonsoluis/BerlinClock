//
//  BerlinClockViewModel.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import BerlinClock

public struct RGBA: Equatable {
    let red: Float
    let green: Float
    let blue: Float
    let alpha: Float

    public init(red: Float, green: Float, blue: Float, alpha: Float = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

public final class BerlinClockViewModel {
    private let clock: BerlinClockTimeProvider
    private let dateProvider: () -> Date
    private let colorMapper: (String) -> RGBA

    public var presenter: ClockPresenter?
    var ticker: Timer?

    public init(clock: BerlinClockTimeProvider, dateProvider: @escaping () -> Date = { Date() }, colorMapper: @escaping (String) -> RGBA) {
        self.clock = clock
        self.dateProvider = dateProvider
        self.colorMapper = colorMapper
    }

    @objc func updateTime(timer: Timer) {

        let colors = clock.time(for: dateProvider())
            .map(String.init)
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
