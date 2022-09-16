//
//  TrafficLightStates.swift
//  TrafficLights
//
//  Created by Дмитрий Никишов on 16.09.2022.
//

import Foundation

enum TrafficLightState: Int {
    case turnOff
    case redOn
    case yellowOn
    case greenOn
    
    mutating func nextWithoutOff(){
        self = TrafficLightState(rawValue: rawValue + 1) ?? TrafficLightState(rawValue: 1)!
    }
}
