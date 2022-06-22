//
//  CircularProgressVC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/16/22.
//

import UIKit

class CircularProgressVC: UIViewController {

    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Draw a circle
        let center = view.center
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: 120,
            startAngle: -CGFloat.pi / 2,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = K.UnifiedColors.greenColor.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = K.UnifiedColors.lightGray.cgColor
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        print("Attemting to animate stroke")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 20
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basicAnim")
    }
    
    func addShapeLayer() {
        let circularPath = UIBezierPath(
            arcCenter: view.center,
            radius: 120,
            startAngle: -CGFloat.pi / 2,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = K.UnifiedColors.greenColor.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = K.UnifiedColors.lightGray.cgColor
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
}
