//
//  ThreadSafeAnimatedClockPresenter.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import UIKit

public class ThreadSafeAnimatedClockPresenter: ClockPresenter {
    private weak var clockPresenter: ClockPresenter?

    public init(otherPresenter: ClockPresenter) {
        self.clockPresenter = otherPresenter
    }

    public func setLampsColor(colors: [RGBA]) {
        dispatchOnMainThread {
            UIView.animate(withDuration: 0.3) {
                self.clockPresenter?.setLampsColor(colors: colors)
            }
        }
    }

    private func dispatchOnMainThread(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
