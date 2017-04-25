//
//  FaceView.swift
//  fingers
//
//  Created by Eric Giannini on 4/25/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class FaceView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let faceRadius = min(bounds.size.width, bounds.size.height) / 2
        let faceCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        path.lineWidth = 5.0
        
        UIColor.blue.set()
        
        path.stroke()
        
        
    }


}
