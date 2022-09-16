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
                view.alpha = 0.5
            }
        }
        
        nextButton.layer.cornerRadius = 10
    }
    
    private func setupHandlers() {
        trafficLightManager.handler = { [weak self] currentState in
            switch currentState {
            case .redOn:
                self?.redLightView.alpha = 1
                self?.yellowLightView.alpha = 0.5
                self?.greenLightView.alpha = 0.5
                
            case .yellowOn:
                self?.redLightView.alpha = 0.5
                self?.yellowLightView.alpha = 1
                self?.greenLightView.alpha = 0.5

            case .greenOn:
                self?.redLightView.alpha = 0.5
                self?.yellowLightView.alpha = 0.5
                self?.greenLightView.alpha = 1

            default:
                self?.redLightView.alpha = 0.5
                self?.yellowLightView.alpha = 0.5
                self?.greenLightView.alpha = 0.5
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

