//
//  MainQueueDispatchDecorator.swift
//  BerlinClockUIKit
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import UIKit

public class MainQueueDispatchDecorator<T> {
    let decoratee: T

    public init(decoratee: T) {
        self.decoratee = decoratee
    }

    func dispatch(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
