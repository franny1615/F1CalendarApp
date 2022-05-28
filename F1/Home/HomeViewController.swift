//
//  ViewController.swift
//  F1
//
//  Created by Francisco F on 5/14/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    private let raceEventModel = RaceEventsModel()
    @IBOutlet weak private var seasonYearPickerView: UIPickerView!
    @IBOutlet weak private var raceCalendarTableView: UITableView!
    @IBOutlet weak private var currentCalendarLabel: UILabel!
    private let currentYear = Calendar.current.component(.year, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.font: UIFont(name: F1Fonts.bold.rawValue, size: 20.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        self.assignDelegatesAndDataSources()
        self.seasonYearPickerView.selectRow(raceEventModel.availableSeasons.count-1, inComponent: 0, animated: true)
        self.fetchRaceCalendar(year: "\(currentYear)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func fetchRaceCalendar(year: String) {
        raceEventModel.getF1CalendarFor(year: year) { title, message in
            DispatchQueue.main.async {
                self.raceCalendarTableView.reloadData()
            }
        }
        currentCalendarLabel.text = "\(year) Calendar"
    }
    
    private func assignDelegatesAndDataSources() {
        raceCalendarTableView.delegate = self
        raceCalendarTableView.dataSource = self
        seasonYearPickerView.delegate = self
        seasonYearPickerView.dataSource = self
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

// MARK: - Picker View Setup
extension HomeViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return raceEventModel.availableSeasons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.bounds.height
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        let text = "\(raceEventModel.availableSeasons[row])"
        label.attributedText = TextHelpers.attributedTextFrom(fontName: F1Fonts.wide.rawValue, fontColor: UIColor.black, fontSize: 20.0, text: text)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.fetchRaceCalendar(year: raceEventModel.availableSeasons[row])
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
