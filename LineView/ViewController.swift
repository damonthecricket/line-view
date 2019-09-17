//
//  ViewController.swift
//  LineView
//
//  Created by Damon Cricket on 17.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    @IBOutlet weak var lineView: LineView?

    // MARK: - Object LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lineView?.startPoint = CGPoint(x: lineView!.bounds.maxX/2.0, y: lineView!.bounds.maxY/2.0)
        lineView?.endPoint = CGPoint(x: lineView!.bounds.maxX, y: lineView!.bounds.maxY/2.0)
        lineView?.color = UIColor.black
        lineView?.thickness = 5.0
    }
}

