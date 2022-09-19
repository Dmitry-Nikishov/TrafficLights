//
//  TrafficLightStateChanger.swift
//  TrafficLights
//
//  Created by Дмитрий Никишов on 16.09.2022.
//

import Foundation

typealias TrafficLightStateChangeHandler = (TrafficLightState) -> Void
typealias TrafficLightStateChangeUiAction = () -> Void

class TrafficLightStateManager {
    private var currentState = TrafficLightState.turnOff
    private var wasCalled = false
    
    var isStarted: Bool {
        get {
            return wasCalled
        }
    }
    
    var handler: TrafficLightStateChangeHandler? {
        didSet {
            handler?(currentState)
        }
    }
    
    func nextLight() {
        if wasCalled == false {
            wasCalled.toggle()
        }
        
        currentState.nextWithoutOff()
        handler?(currentState)
    }
}
