//
//  HomeModel.swift
//  F1
//
//  Created by Francisco F on 5/14/22.
//
import Foundation

class RaceEventsModel {
    private let f1ApiNetworkRequest = GetRaceCalendarByYear()
    var raceCalendar: [Race] = []
    var availableSeasons: [String] {
        var seasons: [String] = []
        let currentYear = Calendar.current.component(.year, from: Date())
        let gapSince1950 = currentYear - 1950
        for i in 0...gapSince1950 {
            seasons.append("\(1950+i)")
        }
        return seasons
    }
    var selectedRaceEvent: Race?
    
    func getF1CalendarFor(year: String, handleCalendarResultMessage: @escaping(String, String) -> Void) {
        f1ApiNetworkRequest.getF1CalendarFor(year: year) { possibleRaceCalendar in
            guard let uRaceCalendar = possibleRaceCalendar else {
                handleCalendarResultMessage("Failed", "Failed to retrieve the race calendar")
                
                return
            }
            self.raceCalendar = uRaceCalendar
            handleCalendarResultMessage("Success", "Race calendar successfully retrieved. ")
        }
    }
}
