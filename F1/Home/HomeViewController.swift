//
//  ViewController.swift
//  F1
//
//  Created by Francisco F on 5/14/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let raceEventModel = RaceEventsModel()
    @IBOutlet weak private var raceCalendarTableView: UITableView!
    @IBOutlet weak private var currentCalendarLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.font: UIFont(name: "TitilliumWeb-Bold", size: 25.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        raceCalendarTableView.delegate = self
        raceCalendarTableView.dataSource = self
        raceEventModel.getF1CalendarFor(year: "2022") { title, message in
            DispatchQueue.main.async {
                let okAction = UIAlertAction(title: "OK", style: .default)
                let resultMessageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                resultMessageAlert.addAction(okAction)
                self.raceCalendarTableView.reloadData()
                self.present(resultMessageAlert, animated: true, completion: nil)
            }
        }
        currentCalendarLabel.text = "2022 Calendar"
    }
}

// MARK: - Table View Setup
extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raceEventModel.raceCalendar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath) as? RaceEventTableViewCell
        let raceEvent = raceEventModel.raceCalendar[indexPath.row]
        cell!.setRaceEventLabelsWith(raceDetails: raceEvent, round: (indexPath.row+1))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRaceEvent = raceEventModel.raceCalendar[indexPath.row]
        raceEventModel.selectedRaceEvent = selectedRaceEvent
        performSegue(withIdentifier: "raceDetailsSegue", sender: self)
    }
}

// MARK: - Dependency Injection
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "raceDetailsSegue",
           let raceDetailsVC = segue.destination as? RaceEventDetailsViewController {
            raceDetailsVC.raceEventModel = self.raceEventModel
        }
    }
}
