//
//  LineLayer.swift
//  LineView
//
//  Created by Damon Cricket on 17.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - LineLayer

class LineLayer: CALayer {

    @NSManaged
    var startPoint: CGPoint
    
    @NSManaged
    var endPoint: CGPoint
    
    @NSManaged
    var color: CGColor
    
    @NSManaged
    var thickness: CGFloat
    
    // MARK: - Object LifeCycle
    
    override init() {
        super.init()
        
        postInitSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        postInitSetup()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        if let lineLayer = layer as? LineLayer {
            startPoint = lineLayer.startPoint
            endPoint = lineLayer.endPoint
            color = lineLayer.color
        }
    }
    
    func postInitSetup() {
        allowsEdgeAntialiasing = true
        contentsScale = UIScreen.main.scale
        needsDisplayOnBoundsChange = true
    }
    
    // MARK: - Display
    
    override open class func needsDisplay(forKey key: String) -> Bool {
        if key == "startPoint" {
            return true
        } else if key == "endPoint" {
            return true
        } else if key == "color" {
            return true
        } else if key == "thickness" {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }
    
    // MARK: - Draw
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        UIGraphicsPushContext(ctx)
        
        ctx.setStrokeColor(color)
        
        ctx.setLineWidth(thickness)
        
        let path = CGMutablePath()
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        ctx.addPath(path)
        
        ctx.strokePath()
        
        UIGraphicsPopContext()
    }
}
