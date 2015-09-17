//
//  HGHistoryFaceTimeViewController.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/9/16.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import UIKit

class HGHistoryFaceTimeViewController: HGFaceTimeViewController , UIPopoverPresentationControllerDelegate{
    override var happiness: Int{
        didSet{
            diagnosticHistory += [happiness]
        }
    }
    
    private let def = NSUserDefaults.standardUserDefaults()
    
    
    var diagnosticHistory  : [Int]{
        get{return def.objectForKey(History.defaultsKey) as? [Int]  ?? []}
        set{def.setObject(newValue, forKey: History.defaultsKey)}
    }
    private struct History{
        static let segueIdentifier = "showHistory"
        static let defaultsKey = "defHistory"
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        showHistory
        if let identifier = segue.identifier {
            switch identifier {
            case History.segueIdentifier:
                if let tvc = segue.destinationViewController as?  TextViewController{
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
        
    }
   
}
