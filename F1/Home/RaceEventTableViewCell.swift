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
        let month = getBackPartFrom(date: raceDetails.raceDate, part: "MMM")
        let weekendStart = getBackPartFrom(date: raceDetails.firstPractice.date, part: "dd")
        let weekendEnd = getBackPartFrom(date: raceDetails.raceDate, part: "dd")
        raceCircuitLabel.text = raceDetails.raceCircuit.circuitName
        raceDateLabel.text = "\(month)\n\(weekendStart)-\(weekendEnd)"
        roundLabel.text = "Round \(round)"
        raceCountryLabel.text = raceDetails.raceCircuit.circuitCountry
    }
    
    func getBackPartFrom(date: String, part: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = part
        let day = dateFormatter.string(from: convertedDate!)

        return day
    }
}
