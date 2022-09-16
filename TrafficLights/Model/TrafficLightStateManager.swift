//
//  TrafficLightStateChanger.swift
//  TrafficLights
//
//  Created by Дмитрий Никишов on 16.09.2022.
//

import Foundation

typealias TrafficLightStateChangeHandler = (TrafficLightState) -> Void

class TrafficLightStateManager {
    private var currentState = TrafficLightState.turnOff
    
    var handler: TrafficLightStateChangeHandler?
    
    func nextLight() {
        currentState.nextWithoutOff()
        handler?(currentState)
    }
}
