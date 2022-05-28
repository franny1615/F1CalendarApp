//
//  RaceEventDetailsViewController.swift
//  F1
//
//  Created by Francisco F on 5/15/22.
//

import Foundation
import MapKit
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
    // Map
    @IBOutlet weak private var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setUpUI() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemRed
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.font: UIFont(name: "Formula1-Display-Bold", size: 20.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        guard let selectedRace = raceEventModel?.selectedRaceEvent else {
            // TODO: you can show a message and return to main dashboard
            return
        }
        self.navigationItem.title = "\(selectedRace.raceCircuit.circuitCountry)"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let month = TextHelpers.getBackPartFrom(date: selectedRace.raceDate, part: "MMM")
        let raceDay = TextHelpers.getBackPartFrom(date: selectedRace.raceDate, part: "dd")
        raceNameLabel.text = selectedRace.raceCircuit.circuitName
        raceDateLabel.text = "\(month)\n\(raceDay)"
        raceTimeLabel.text = TextHelpers.getPrettyTimeFrom(time: selectedRace.raceTime)
        
        let fp1Day = TextHelpers.getBackPartFrom(date: selectedRace.firstPractice.date, part: "dd")
        firstPracticeDateLabel.text = "\(month)\n\(fp1Day)"
        firstPracticeTimeLabel.text = TextHelpers.getPrettyTimeFrom(time: selectedRace.firstPractice.time)
        
        let fp2Day = TextHelpers.getBackPartFrom(date: selectedRace.secondPractice.date, part: "dd")
        secondPracticeDateLabel.text =  "\(month)\n\(fp2Day)"
        secondPracticeTimeLabel.text = TextHelpers.getPrettyTimeFrom(time: selectedRace.secondPractice.time)
        
        let fp3Day = TextHelpers.getBackPartFrom(date: selectedRace.thirdPractice.date, part: "dd")
        thirdPracticeDateLabel.text =   "\(month)\n\(fp3Day)"
        thirdPracticeTimeLabel.text = TextHelpers.getPrettyTimeFrom(time: selectedRace.thirdPractice.time)
        
        let qualiDay = TextHelpers.getBackPartFrom(date: selectedRace.qualifying.date, part: "dd")
        qualiDateLabel.text =   "\(month)\n\(qualiDay)"
        qualiTimeLabel.text = TextHelpers.getPrettyTimeFrom(time: selectedRace.qualifying.time)
        
        let raceLocation = CLLocation(latitude: CLLocationDegrees(selectedRace.raceCircuit.latitude), longitude: CLLocationDegrees(selectedRace.raceCircuit.longitude))
        
        map.centerToLocation(raceLocation)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 3000) {
        let coordinateRegion = MKCoordinateRegion(
              center: location.coordinate,
              latitudinalMeters: regionRadius,
              longitudinalMeters: regionRadius)
            setRegion(coordinateRegion, animated: true)
    }
}
