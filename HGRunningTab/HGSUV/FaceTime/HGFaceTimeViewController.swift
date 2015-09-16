//
//  HGFaceTimeViewController.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/9/11.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import UIKit

class HGFaceTimeViewController: HGBaseRootViewController , FaceViewDataDource {

    @IBOutlet weak var faceView: HGFaceView!{
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            
        }
    }
    var happiness: Int = 100 {
        didSet{
            happiness = min(max(happiness, 0), 100)
            updataUI()
        }
    }
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    @IBAction func changehappiness(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case  .Ended: fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default : break
            
        }
        
    }
   
    func updataUI(){
        faceView.setNeedsDisplay()
    }
    
    func smilinesForFaceView(sender: HGFaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
}
