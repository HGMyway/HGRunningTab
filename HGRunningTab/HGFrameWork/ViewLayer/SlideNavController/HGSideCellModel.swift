//
//  HGSideCellModel.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/8/17.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import Foundation


@objc
class HGSideCellModel {

    let title: String
    let DNAStr : String

    init(title:String,DNAStr : String){
        self.title = title
        self.DNAStr = DNAStr
        
    }
    class func allCellData() -> Array<HGSideCellModel>{
        return [
            HGSideCellModel(title: "运动", DNAStr: "sport"),
            HGSideCellModel(title: "我", DNAStr: "myway")
        
            
        ]
    }
}
