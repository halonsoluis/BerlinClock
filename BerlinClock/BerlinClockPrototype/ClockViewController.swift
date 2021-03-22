//
//  ClockViewController.swift
//  BerlinClockPrototype
//
//  Created by ***REMOVED*** on 22/03/2021.
//

import Foundation
import UIKit

final class ClockViewController: UIViewController {

    @IBOutlet weak var seconds: UIView!

    @IBOutlet var fiveHourRow: [UIView]!
    @IBOutlet var singleHourRow: [UIView]!

    @IBOutlet var fiveMinuteRow: [UIView]!
    @IBOutlet var singleMinuteRow: [UIView]!
}
