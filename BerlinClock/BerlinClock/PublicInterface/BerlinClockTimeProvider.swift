//
//  BerlinClockTimeProvider.swift
//  BerlinClock
//
//  Created by ---- ------ on 21/03/2021.
//

import Foundation

public protocol BerlinClockTimeProvider {
    func time(for date: Date) -> String
}
