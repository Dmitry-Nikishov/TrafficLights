//
//  ViewController.swift
//  TrafficLights
//
//  Created by Дмитрий Никишов on 16.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenLightView: UIView!
    @IBOutlet weak var yellowLightView: UIView!
    @IBOutlet weak var redLightView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private let trafficLightManager = TrafficLightStateManager()
    
    private func configureSubItems() {
        [greenLightView, yellowLightView, redLightView].forEach { view in
            if let view = view {
                view.layer.cornerRadius = view.layer.bounds.width / 2
                view.clipsToBounds = true
                view.alpha = TrafficLightMode.off.rawValue
            }
        }
        
        nextButton.layer.cornerRadius = 10
    }
    
    private func setupHandlers() {
        trafficLightManager.handler = { [weak self] currentState in
            switch currentState {
            case .redOn:
                self?.redLightView.alpha = TrafficLightMode.on.rawValue
                self?.yellowLightView.alpha = TrafficLightMode.off.rawValue
                self?.greenLightView.alpha = TrafficLightMode.off.rawValue
                
            case .yellowOn:
                self?.redLightView.alpha = TrafficLightMode.off.rawValue
                self?.yellowLightView.alpha = TrafficLightMode.on.rawValue
                self?.greenLightView.alpha = TrafficLightMode.off.rawValue

            case .greenOn:
                self?.redLightView.alpha = TrafficLightMode.off.rawValue
                self?.yellowLightView.alpha = TrafficLightMode.off.rawValue
                self?.greenLightView.alpha = TrafficLightMode.on.rawValue

            default:
                self?.redLightView.alpha = TrafficLightMode.off.rawValue
                self?.yellowLightView.alpha = TrafficLightMode.off.rawValue
                self?.greenLightView.alpha = TrafficLightMode.off.rawValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubItems()
        
        setupHandlers()
    }

    @IBAction func nextButtonDidTapped() {
        trafficLightManager.nextLight()
    }
}

