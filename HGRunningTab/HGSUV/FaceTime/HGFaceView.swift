//
//  HGFaceView.swift
//  HGRunningTab
//
//  Created by 任是无情也动人 on 15/9/1.
//  Copyright (c) 2015年 ismyway. All rights reserved.
//

import UIKit

protocol FaceViewDataDource: class{
    func smilinesForFaceView(sender: HGFaceView) -> Double?
}

@IBDesignable
class HGFaceView: UIView {
    
    
    weak var dataSource: FaceViewDataDource?
    
    
    func scale(gesture: UIPinchGestureRecognizer){
        if gesture.state == .Changed {
                scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        lineColor.set()
        
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        let smiliness = dataSource?.smilinesForFaceView(self) ?? 0.0
        let smilePath = bezierPathForSmile(smiliness)
        smilePath.stroke()
        
        
    }

    
    @IBInspectable
    var scale : CGFloat = 0.9 { didSet{ setNeedsDisplay() }}
        @IBInspectable
    var lineWidth : CGFloat = 3 {   didSet{  setNeedsDisplay()} }
        @IBInspectable
    var lineColor : UIColor = SWColor.themeColor() {didSet{setNeedsDisplay()} }
    
    var faceCenter : CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffSetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffSetRatio: CGFloat = 3
    }
    
    private enum Eye  { case Left ,Right  }
    
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath{
        let eyeRadius  = faceRadius  /  Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffSetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizontalSeparation/2
        case .Right: eyeCenter.x += eyeHorizontalSeparation/2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        return path
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath{
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffSetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
        
    }

    
}
