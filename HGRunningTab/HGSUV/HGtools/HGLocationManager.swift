//
//  HGLocationManager.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/8/25.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import Foundation

import CoreLocation

public class HGLocationManager {
    
    
//    提供静态访问方法
    public class  var shared: HGLocationManager{
        dispatch_once(&Inner.token){
            Inner.instance = HGLocationManager()
        }
        return Inner.instance!
    }

//    私有化构造方法
    private init(){
    }
    
//    通过结构体保存实例的引用
    private struct Inner {
        private static var instance: HGLocationManager?
        private static var token: dispatch_once_t = 0
    }
}
