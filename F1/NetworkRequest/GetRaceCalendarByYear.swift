//
//  F1ApiNetworkRequests.swift
//  F1
//
//  Created by Francisco F on 5/14/22.
//
import Foundation

class GetRaceCalendarByYear: NSObject, XMLParserDelegate {
    enum ParentKeys: String, CaseIterable {
        case race = "Race"
        case circuit = "Circuit"
        case firstPractice = "FirstPractice"
        case secondPractice = "SecondPractice"
        case thirdPractice = "ThirdPractice"
        case qualifying = "Qualifying"
    }
    
    enum ChildKeys: String {
        case raceName = "RaceName"
        case circuitName = "CircuitName"
        case circuitCity = "Locality"
        case circuitContry = "Country"
        case date = "Date"
        case time = "Time"
    }
    
    private let url = "https://ergast.com/api/f1/"
    
    private var childElementName = ""
    private var parentElementName = ""
    
    private var raceCalendar: [Race] = []
    private var currentRace: Race = Race(raceName: "",
                                         raceCircuit: Circuit(circuitName: "", circuitCity: "", circuitCountry: ""),
                                         raceDate: "",
                                         raceTime: "",
                                         firstPractice: Session(sessionType: .practice, date: "", time: ""),
                                         secondPractice: Session(sessionType: .practice, date: "", time: ""),
                                         thirdPractice: Session(sessionType: .practice, date: "", time: ""),
                                         qualifying: Session(sessionType: .qualifying, date: "", time: ""))
    
    func getF1CalendarFor(year: String, handleResponse: @escaping([Race]?) -> Void) {
        guard let urlWithYear = URL(string: url+year) else {
            handleResponse(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlWithYear) { data, response, error in
            guard let uData = data else {
                handleResponse(nil)
                return
            }
            let parser = XMLParser(data: uData)
            parser.delegate = self
            parser.parse()
            handleResponse(self.raceCalendar)
        }
        task.resume()
    }
}

// MARK: - XMLParsing
extension GetRaceCalendarByYear {
    // this one should be used to reset the temporary variable
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        var foundParent = false
        for parentKey in ParentKeys.allCases where elementName == parentKey.rawValue && !foundParent {
            foundParent = true
            break
        }
        if !foundParent {
            self.childElementName = elementName
        } else {
            self.parentElementName = elementName
        }
    }

    // this one is used to append to the array you're working on
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == ParentKeys.race.rawValue {
            raceCalendar.append(currentRace)
        }
    }

    // this one is used to append data to the object you're constructing that goes into the array
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            switch self.parentElementName {
            case ParentKeys.race.rawValue:
                switch self.childElementName {
                case ChildKeys.raceName.rawValue:
                    currentRace.raceName = data
                default:
                    break
                }
            case ParentKeys.circuit.rawValue:
                switch self.childElementName {
                case ChildKeys.circuitName.rawValue:
                    currentRace.raceCircuit.circuitName = data
                case ChildKeys.circuitCity.rawValue:
                    currentRace.raceCircuit.circuitCity = data
                case ChildKeys.circuitContry.rawValue:
                    currentRace.raceCircuit.circuitCountry = data
                case ChildKeys.date.rawValue:
                    currentRace.raceDate = data
                case ChildKeys.time.rawValue:
                    currentRace.raceTime = data
                default:
                    break
                }
            case ParentKeys.firstPractice.rawValue:
                switch self.childElementName {
                case ChildKeys.date.rawValue:
                    currentRace.firstPractice.date = data
                case ChildKeys.time.rawValue:
                    currentRace.firstPractice.time = data
                default:
                    break
                }
            case ParentKeys.secondPractice.rawValue:
                switch self.childElementName {
                case ChildKeys.date.rawValue:
                    currentRace.secondPractice.date = data
                case ChildKeys.time.rawValue:
                    currentRace.secondPractice.time = data
                default:
                    break
                }
            case ParentKeys.thirdPractice.rawValue:
                switch self.childElementName {
                case ChildKeys.date.rawValue:
                    currentRace.thirdPractice.date = data
                case ChildKeys.time.rawValue:
                    currentRace.thirdPractice.time = data
                default:
                    break
                }
            case ParentKeys.qualifying.rawValue:
                switch self.childElementName {
                case ChildKeys.date.rawValue:
                    currentRace.qualifying.date = data
                case ChildKeys.time.rawValue:
                    currentRace.qualifying.time = data
                default:
                    break
                }
            default:
                break
            }
        }
    }
}
