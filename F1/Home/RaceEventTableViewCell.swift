//
//  RaceEventTableViewCell.swift
//  F1
//
//  Created by Francisco F on 5/15/22.
//

import Foundation
import UIKit

class RaceEventTableViewCell: UITableViewCell {
    @IBOutlet weak private var raceDateLabel: UILabel!
    @IBOutlet weak private var roundLabel: UILabel!
    @IBOutlet weak private var raceCircuitLabel: UILabel!
    @IBOutlet weak private var raceCountryLabel: UILabel!
    
    func setRaceEventLabelsWith(raceDetails: Race, round: Int) {
        let month = TextHelpers.getBackPartFrom(date: raceDetails.raceDate, part: "MMM")
        let weekendStart = TextHelpers.getBackPartFrom(date: raceDetails.firstPractice.date, part: "dd")
        let weekendEnd = TextHelpers.getBackPartFrom(date: raceDetails.raceDate, part: "dd")
        raceCircuitLabel.text = raceDetails.raceCircuit.circuitName
        raceDateLabel.text = "\(month)\n\(weekendStart)-\(weekendEnd)"
        roundLabel.text = "Round \(round)"
        raceCountryLabel.text = raceDetails.raceCircuit.circuitCountry
    }
}
