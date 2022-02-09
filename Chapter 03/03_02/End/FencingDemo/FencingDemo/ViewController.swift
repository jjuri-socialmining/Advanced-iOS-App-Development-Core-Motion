//
//  ViewController.swift
//  FencingDemo
//
//  Created by Steven Lipton on 5/16/17.
//  Copyright © 2017 Steven Lipton. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    let motionManager = CMMotionManager()
    
    func isDevicesAvailable()->Bool{
        //let gyroAvailable = motionManager.isGyroAvailable
        //let accelAvailable = motionManager.isAccelerometerAvailable
        if !motionManager.isDeviceMotionAvailable{
            let alert = UIAlertController(title: "Fencing", message: "Your device does not have the necessary sensors. You mihgt want to try on another device.", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            print("Devices not detected")
        }
        return motionManager.isDeviceMotionAvailable
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isDevicesAvailable(){
            print("Core Motion Launched")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

