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
    let interval = 0.1
    var timer = Timer()
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
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { (timer) in
            if let deviceMotion = self.motionManager.deviceMotion{
                let accel = deviceMotion.userAcceleration
                print(String(format:"X: %7.4 Y: %7.4f",accel.x, accel.y))
                if accel.y >= 2.0{
                    var gyro = CMRotationRate()
                    if self.motionManager.isGyroAvailable{
                        gyro = deviceMotion.rotationRate
                        print(String(format:"Rotation Rate Z: %7.4f",gyro.z))
                    } else {
                        print("Gyro not available yet")
                    }
                    if gyro.z > 4.0 || gyro.z < -4.0 {
                        print("//////Slash\\\\\\")
                    }else{
                        print("*****Thrust*****")
                    }
                }else{
                    if accel.x <= -1.0 || accel.x >= 1.0{
                    print("=======Parry=====")
                    }
                }
                            }
        })
    }
    
    func myDeviceMotion(){
        motionManager.deviceMotionUpdateInterval = interval
        motionManager.startDeviceMotionUpdates()
        startTimer()
        /*
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (deviceMotion, error) in
            if let deviceMotion = deviceMotion{
                print("\(deviceMotion.userAcceleration.x) \(Date())")
            }
        }*/
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        motionManager.stopDeviceMotionUpdates()
        timer.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isDevicesAvailable(){
            print("Core Motion Launched")
            myDeviceMotion()
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

