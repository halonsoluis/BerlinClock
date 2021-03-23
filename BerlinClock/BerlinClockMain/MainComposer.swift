//
//  MainComposer.swift
//  BerlinClockMain
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import Foundation
import BerlinClock
import BerlinClockUIKit
import UIKit

final class MainComposer {

    func start(using window: UIWindow) {
        let berlinClock = BerlinClock.create()
        let interactor = BerlinClockViewModel(clock: berlinClock)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let clockView = storyboard.instantiateViewController(withIdentifier: "Clock") as? BerlinClockViewController else {
            fatalError("ViewController is not the expected")
        }
        clockView.connect(interactor: interactor)
        interactor.presenter = ThreadSafeAnimatedClockPresenter(otherPresenter: clockView)

        window.rootViewController = clockView
    }
}
