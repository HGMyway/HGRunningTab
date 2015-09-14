//
//  HGSideCellModel.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/8/17.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import Foundation
import UIKit


@objc
class HGSideCellModel {

    let title: String
    let DNAStr : String
    let selectIndex : Int

    init(title:String,DNAStr : String,selectIndex : Int){
        self.title = title
        self.DNAStr = DNAStr
        self.selectIndex = selectIndex
        
    } 
    class func allCellData() -> Array<HGSideCellModel>{
        
        if let hgTabbar = UIStoryboard.tabbarViewController(){
            var resultArr = NSMutableArray()
            
            for (index , nav) in  enumerate( hgTabbar.viewControllers as! [UINavigationController] ){
                
                 var navTitle = nav.title
                if navTitle == nil {
                    navTitle = ""
                }
                
                resultArr .addObject(HGSideCellModel(title:navTitle!, DNAStr: "myway", selectIndex: index))
            }
            
            return resultArr.copy() as! Array<HGSideCellModel>
        }
        
        
        return  []
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    
    class func tabbarViewController() -> HGTabBarViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("HGTabBarViewController") as? HGTabBarViewController
    }
    
}
