//
//  FaceView.swift
//  fingers
//
//  Created by Eric Giannini on 4/25/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.9
    
    var eyesOpen: Bool = true
    
    private var faceRadius: CGFloat {
        
        return min(bounds.size.width, bounds.size.height) / 2 * scale
        
    }
    
    private var faceCenter: CGPoint {
        
        return CGPoint(x: bounds.midX, y: bounds.midY)
        
    }
    
    private func pathForFace() -> UIBezierPath {
        
        let path = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        path.lineWidth = 5.0
        
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
        
        let path = UIBezierPath(rect: mouthRect)
        
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
        

        path.lineWidth = 5.0
        
        return path
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        UIColor.blue.set()
        
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
