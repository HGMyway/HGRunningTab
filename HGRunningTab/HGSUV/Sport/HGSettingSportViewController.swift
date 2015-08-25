//
//  HGSettingSportViewController.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/8/18.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import UIKit

import CoreLocation

class HGSettingSportViewController: HGBaseViewController {
    
    
    @IBOutlet weak var acceleLabel: UILabel!
    
    @IBOutlet weak var gyroLabel: UILabel!
    
    @IBOutlet weak var magnetometerLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    
    //变量
    var speedValue :Double{
        set{
            speedLabel.text = "\(newValue)"
        }
        
        get{
                return NSNumberFormatter().numberFromString(speedLabel.text!)!.doubleValue
        }
        
    }
    
    var forceLocation : CLLocation?
    
//    let hgMotion = HGMotionKit.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        
        
        //        hgMotion.delegate = self
//        
//        hgMotion.getAccelerometerValues(interval: 1.0) { (x, y, z) -> () in
//            
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.acceleLabel.text = "  x = \(x) \n  y = \(y) \n  z = \(z)"
////                println("x = \(x) y = \(y) z = \(z)")
//            })
//            
//            
//        }
//        
//        hgMotion.getGyroValues(interval: 1.0) { (x, y, z) -> () in
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.gyroLabel.text = "  x = \(x) \n  y = \(y) \n  z = \(z)"
////                println("x = \(x) y = \(y) z = \(z)")
//            })
//        }
//        
//        hgMotion.getMagnetometerValues(interval: 1.0) { (x, y, z) -> () in
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.magnetometerLabel.text = "  x = \(x) \n  y = \(y) \n  z = \(z)"
////                println("x = \(x) y = \(y) z = \(z)")
//            })
//        }
//        
        
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
//        hgMotion.stopAccelerometerUpdates()
//        hgMotion.stopGyroUpdates()
//        hgMotion.stopmagnetometerUpdates()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    let  hgLocationManager = CLLocationManager()
    
    @IBAction func startRunningAction(sender: UIButton) {
        
        if sender.selected == false {
            
            if CLLocationManager.locationServicesEnabled(){
                hgLocationManager.delegate = self
                hgLocationManager.desiredAccuracy  = kCLLocationAccuracyBest //定位精度

                hgLocationManager.distanceFilter = 0.5 //距离过滤，设备移动更新位置信息的最小距离
                hgLocationManager.requestWhenInUseAuthorization()
                
                
                hgLocationManager.startUpdatingLocation()
                
                sender.selected = true
                sender.setTitle("继续", forState: UIControlState.Normal)
            }else
            {
                sender.setTitle("定位失败", forState: UIControlState.Normal)
            }
            
        }else{
            hgLocationManager.stopUpdatingLocation()
            sender.selected = false
        }
        
      
    }
    

    
    
}

//extension HGSettingSportViewController: HGMotionKitDelegate{
//    func retrieveAccelerometerValues(x: Double, y: Double, z: Double, absoluteValue: Double) {
//        acceleLabel.text = "x = \(x) y = \(y) z = \(z)"
//
//        println("x = \(x) y = \(y) z = \(z)")
//    }
//
//    func retrieveGyroscopeValues(x: Double, y: Double, z: Double, absoluteValue: Double) {
//        
//    }
//}


extension HGSettingSportViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
      let   curLocation = locations.last as! CLLocation
        
        acceleLabel.text = curLocation.description
        
        gyroLabel.text = "\(curLocation.coordinate.latitude)  .   \(curLocation.coordinate.longitude)"
        
        magnetometerLabel.text = "\(curLocation.horizontalAccuracy) + \(curLocation.verticalAccuracy)"
        
        if  curLocation.speed > 0
        {
            if forceLocation != nil {
                 let  intervalTime = curLocation.timestamp.timeIntervalSinceDate(forceLocation!.timestamp)
                    speedValue = speedValue + intervalTime*(curLocation.speed + forceLocation!.speed)/2.0

            }
            forceLocation = curLocation
        }
        
        println("dddd")
        
        
      
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
    }
}

