//
//  MainComposer.swift
//  BerlinClockMain
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import BerlinClock
import BerlinClockUIKit
import UIKit

final class MainComposer {

    func start(using window: UIWindow) {

        let (schema, mapper) = configureColorHandling()

        let berlinClock = BerlinClockFactory.create(colorSchema: schema)
        let interactor = BerlinClockViewModel(
            clock: berlinClock,
            colorMapper: mapper,
            tickerFactory: TickerFactoryImplementation()
        )

        guard let clockView = obtainClockView() else {
            fatalError("ViewController is not the expected")
        }

        clockView.connect(interactor: interactor)
        interactor.presenter = MainQueueDispatchDecorator(decoratee: clockView)

        window.rootViewController = clockView
    }

    private func configureColorHandling() -> (ColorSchema, mapper: (Character) -> CGColor) {
        let yellow: Character = "Y"
        let red: Character = "R"
        let off: Character = "O"

        let colorMap: [Character: CGColor] = [
            yellow: UIColor.systemYellow.cgColor,
            red: UIColor.systemRed.cgColor,
            off: UIColor.black.withAlphaComponent(0.2).cgColor
        ]

        let colorSchema = ColorSchema(
            off: off,
            seconds: yellow,
            minutes: yellow,
            minutesVisualAid: red,
            hours: red
        )

        let mapper: (Character) -> CGColor = { colorRepresentation in
            let unexpectedStringColor = UIColor.black.cgColor
            return (colorMap[colorRepresentation] ?? unexpectedStringColor)
        }

        return (colorSchema, mapper)
    }

    private func obtainClockView() -> BerlinClockViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
            .instantiateViewController(withIdentifier: "Clock") as? BerlinClockViewController
    }
}

extension MainQueueDispatchDecorator: ClockPresenter where T == ClockPresenter {
    public func setLampsColor(colors: [CGColor]) {
        dispatch {
            self.decoratee.setLampsColor(colors: colors)
        }
    }
}
