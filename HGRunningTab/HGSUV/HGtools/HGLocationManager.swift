//
//  HGLocationManager.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/8/25.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//
 
import Foundation

import CoreLocation

protocol HGLocationManagerDelegate : NSObjectProtocol {
    
}


public class HGLocationManager: NSObject, CLLocationManagerDelegate {
    
    
//    提供静态访问方法
    public class  var shared: HGLocationManager{
        dispatch_once(&Inner.token){
            Inner.instance = HGLocationManager()
        }
        return Inner.instance!
    }
    
//    通过结构体保存实例的引用
    private struct Inner {
        private static var instance: HGLocationManager?
        private static var token: dispatch_once_t = 0
    }
    
    
//    ／／／／／／／
    
    static let sharedInstance = HGLocationManager()
    
   private let locationManager: CLLocationManager
    
    
    private  override init() {
        locationManager = CLLocationManager()
    
    }  //私有化init方法，防止其他对象使用这个类的默认的（）
    
    func startUpdatingLocation(){
        locationManager.startUpdatingLocation()
    }
    

}


