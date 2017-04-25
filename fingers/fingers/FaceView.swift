//
//  FaceView.swift
//  fingers
//
//  Created by Eric Giannini on 4/25/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

/* 

 @IBDesignable provides Interface Builder access to the explicitly typed @IBInspectable properties
 
*/

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.9
    
    @IBInspectable
    var eyesOpen: Bool = true
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0
    
    @IBInspectable
    var color: UIColor = UIColor.blue
    
    public var mouthCurvature: Double = 1.0 // is full smile; -1.0 is full frown
    
    private var faceRadius: CGFloat {
        
        return min(bounds.size.width, bounds.size.height) / 2 * scale
        
    }
    
    private var faceCenter: CGPoint {
        
        return CGPoint(x: bounds.midX, y: bounds.midY)
        
    }
    
    private func pathForFace() -> UIBezierPath {
        
        let path = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        path.lineWidth = lineWidth
        
        return path
        
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private func pathForMouth() -> UIBezierPath {
        
        let mouthWidth = faceRadius / Ratios.faceRadiusToMouthWidth
        let mouthHeight = faceRadius / Ratios.faceRadiusToMouthHeight
        let mouthOffset = faceRadius / Ratios.faceRadiusToMouthOffset
        
        let mouthRect = CGRect(x: faceCenter.x - mouthWidth / 2,
                               y: faceCenter.y + mouthOffset,
                               width: mouthWidth,
                               height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        
        
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath{
        
        func centerOfEye(_ eye:Eye) -> CGPoint {
            let eyeOffset = faceRadius / Ratios.faceRadiusToEyeOffset
            var eyeCenter = faceCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = faceRadius / Ratios.faceRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        let path: UIBezierPath
        
        if eyesOpen {
            
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            
            
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            
            
            
        }
        
        
        path.lineWidth = lineWidth
        
        return path
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        color.set()
        
        [pathForFace(), pathForEye(.left), pathForEye(.right),  pathForMouth()].forEach {$0.stroke()}
        
    }
    
    private struct Ratios {
        static let faceRadiusToEyeOffset: CGFloat = 3
        static let faceRadiusToEyeRadius: CGFloat = 10
        static let faceRadiusToMouthWidth: CGFloat = 1
        static let faceRadiusToMouthHeight: CGFloat = 3
        static let faceRadiusToMouthOffset: CGFloat = 3
    }
    
}
