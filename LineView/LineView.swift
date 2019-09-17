//
//  LineView.swift
//  LineView
//
//  Created by Damon Cricket on 17.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - LineView

class LineView: UIView {

    var startPoint: CGPoint {
        set {
            lineLayer.startPoint = newValue
        } get {
            return lineLayer.startPoint
        }
    }
    
    var endPoint: CGPoint {
        set {
            lineLayer.endPoint = newValue
        } get {
            return lineLayer.endPoint
        }
    }
    
    var color: UIColor {
        set {
            lineLayer.color = newValue.cgColor
        } get {
            return UIColor(cgColor: lineLayer.color)
        }
    }
    
    var thickness: CGFloat {
        set {
            lineLayer.thickness = newValue
        } get {
            return lineLayer.thickness
        }
    }
    
    var lineLayer: LineLayer {
        return layer as! LineLayer
    }
    
    override open class var layerClass: AnyClass {
        return LineLayer.self
    }
}
