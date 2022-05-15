//
//  RaceEventDetailsViewController.swift
//  F1
//
//  Created by Francisco F on 5/15/22.
//

import Foundation
import UIKit

class RaceEventDetailsViewController: UIViewController {
    var raceEventModel: RaceEventsModel?
    // Race Details
    @IBOutlet weak private var raceNameLabel: UILabel!
    @IBOutlet weak private var raceDateLabel: UILabel!
    @IBOutlet weak private var raceTimeLabel: UILabel!
    // First Practice
    @IBOutlet weak private var firstPracticeDateLabel: UILabel!
    @IBOutlet weak private var firstPracticeTimeLabel: UILabel!
    // Second Practice
    @IBOutlet weak private var secondPracticeDateLabel: UILabel!
    @IBOutlet weak private var secondPracticeTimeLabel: UILabel!
    // Third Practice
    @IBOutlet weak private var thirdPracticeDateLabel: UILabel!
    @IBOutlet weak private var thirdPracticeTimeLabel: UILabel!
    // Qualifying
    @IBOutlet weak private var qualiDateLabel: UILabel!
    @IBOutlet weak private var qualiTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        guard let selectedRace = raceEventModel?.selectedRaceEvent else {
            // TODO: you can show a message and return to main dashboard
            return
        }
        raceNameLabel.text = selectedRace.raceName
        raceDateLabel.text = selectedRace.raceDate
        raceTimeLabel.text = selectedRace.raceTime
        
        firstPracticeDateLabel.text = selectedRace.firstPractice.date
        firstPracticeTimeLabel.text = selectedRace.firstPractice.time
        
        secondPracticeDateLabel.text = selectedRace.secondPractice.date
        secondPracticeTimeLabel.text = selectedRace.secondPractice.time
        
        thirdPracticeDateLabel.text = selectedRace.thirdPractice.date
        thirdPracticeTimeLabel.text = selectedRace.thirdPractice.time
        
        qualiDateLabel.text = selectedRace.qualifying.date
        qualiTimeLabel.text = selectedRace.qualifying.time
    }
}
