//
//  RaceEventTableViewCell.swift
//  F1
//
//  Created by Francisco F on 5/15/22.
//

import Foundation
import UIKit

class RaceEventTableViewCell: UITableViewCell {
    @IBOutlet weak private var raceNameLabel: UILabel!
    @IBOutlet weak private var raceDateLabel: UILabel!
    @IBOutlet weak private var raceTimeLabel: UILabel!
    
    func setRaceEventLabelsWith(raceName: String, raceDate: String, raceTime: String) {
        raceNameLabel.text = raceName
        raceDateLabel.text = raceDate
        raceTimeLabel.text = raceTime
    }
}
