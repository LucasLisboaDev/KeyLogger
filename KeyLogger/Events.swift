//
//  Events.swift
//  KeyLogger
//
//  Created by Lucas Lisboa  on 3/23/25.
//

import Foundation


struct Event: Decodable {
    let type: String
    let timestamp: Double
    let data: String
}
