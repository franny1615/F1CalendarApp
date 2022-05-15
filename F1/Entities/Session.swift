//
//  Session.swift
//  F1
//
//  Created by Francisco F on 5/14/22.
//

import Foundation

typealias ST = SessionType
enum SessionType: Int {
    case qualifying = 0
    case practice = 1
}

struct Session {
    var sessionType: SessionType
    var date: String
    var time: String
}
