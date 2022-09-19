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
    
    private func initialViewConfiguration() {
        nextButton.layer.cornerRadius = 10
    }
    
    private func configureSubviewsAfterLayout() {
        [greenLightView, yellowLightView, redLightView].forEach { view in
            if let view = view {
                view.layer.cornerRadius = view.layer.bounds.width / 2
            }
        }
    }
    
    private func setupHandlers() {
        trafficLightManager.handler = { [weak self] currentState in
            var uiAction: TrafficLightStateChangeUiAction
            
            switch currentState {
            case .redOn:
                uiAction = { [weak self] in
                    self?.redLightView.alpha = TrafficLightMode.on.rawValue
                    self?.yellowLightView.alpha = TrafficLightMode.off.rawValue
                    self?.greenLightView.alpha = TrafficLightMode.off.rawValue
                }
                
            case .yellowOn:
                uiAction = { [weak self] in
                    self?.redLightView.alpha = TrafficLightMode.off.rawValue
                    self?.yellowLightView.alpha = TrafficLightMode.on.rawValue
                    self?.greenLightView.alpha = TrafficLightMode.off.rawValue
                }

            case .greenOn:
                uiAction = { [weak self] in
                    self?.redLightView.alpha = TrafficLightMode.off.rawValue
                    self?.yellowLightView.alpha = TrafficLightMode.off.rawValue
                    self?.greenLightView.alpha = TrafficLightMode.on.rawValue
                }

            default:
                uiAction = { [weak self] in
                    self?.redLightView.alpha = TrafficLightMode.off.rawValue
                    self?.yellowLightView.alpha = TrafficLightMode.off.rawValue
                    self?.greenLightView.alpha = TrafficLightMode.off.rawValue
                }
            }
            
            UIView.animate(withDuration: 0.3) {
                uiAction()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialViewConfiguration()
        setupHandlers()
    }
    
    override func viewWillLayoutSubviews() {
        configureSubviewsAfterLayout()
    }

    @IBAction func nextButtonDidTapped() {
        if trafficLightManager.isStarted == false {
            nextButton.setTitle("Next", for: .normal)
        }
        
        trafficLightManager.nextLight()
    }
}

