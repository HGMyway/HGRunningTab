//
//  HGSettingSportViewController.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/8/18.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import UIKit

class HGSettingSportViewController: HGBaseViewController {
    
    
    @IBOutlet weak var acceleLabel: UILabel!
    
    @IBOutlet weak var gyroLabel: UILabel!
    
    @IBOutlet weak var magnetometerLabel: UILabel!
    
    
    let hgMotion = HGMotionKit.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        hgMotion.delegate = self
        
        
        
        hgMotion.getAccelerometerValues(interval: 1.0) { (x, y, z) -> () in
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.acceleLabel.text = "  x = \(x) \n  y = \(y) \n  z = \(z)"
                
//                println("x = \(x) y = \(y) z = \(z)")
            })
            
            
        }
        
        hgMotion.getGyroValues(interval: 1.0) { (x, y, z) -> () in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.gyroLabel.text = "  x = \(x) \n  y = \(y) \n  z = \(z)"
//                println("x = \(x) y = \(y) z = \(z)")
            })
        }
        
        hgMotion.getMagnetometerValues(interval: 1.0) { (x, y, z) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.magnetometerLabel.text = "  x = \(x) \n  y = \(y) \n  z = \(z)"
//                println("x = \(x) y = \(y) z = \(z)")
            })
        }
        
        
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        hgMotion.stopAccelerometerUpdates()
        hgMotion.stopGyroUpdates()
        hgMotion.stopmagnetometerUpdates()
        
        
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



