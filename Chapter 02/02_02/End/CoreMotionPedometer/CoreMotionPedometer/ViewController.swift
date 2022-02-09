//
//  ViewController.swift
//  CoreMotionPedometer
//
//  Created by Steven Lipton on 5/15/17.
//  Copyright © 2017 Steven Lipton. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var pedometer = CMPedometer()
    let goGreen = UIColor(red: 0, green: 1.0, blue: 0.15, alpha: 1.0)
    let stopRed = UIColor(red: 1.0, green: 0, blue: 0.15, alpha: 1.0)
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startStopPedometer: UIButton!
    @IBAction func startStopPedometer(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start"{
            statusLabel.text = "Pedometer On"
            sender.setTitle("Stop", for: .normal)
            sender.backgroundColor = stopRed
            if CMPedometer.isStepCountingAvailable(){
                pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
                    if let pedometerData = pedometerData{
                        self.stepsLabel.text = "Steps: \(pedometerData.numberOfSteps)"
                    }
                })
            } else {
                print("Step counting not available")
            }
            
        } else {
            pedometer.stopUpdates()
            statusLabel.text = "Pedometer Off"
            sender.backgroundColor = goGreen
            sender.setTitle("Start", for: .normal)
        }
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopPedometer.backgroundColor = goGreen
        stepsLabel.text = "Steps: Not Available"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

