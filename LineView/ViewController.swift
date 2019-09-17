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
    
    @IBOutlet weak var changeBarButtonItem: UIBarButtonItem?
    
    @IBOutlet weak var segmentedCotrnol: UISegmentedControl?
    
    @IBOutlet weak var xTextField: UITextField?
    @IBOutlet weak var yTextField: UITextField?

    @IBOutlet weak var colorPickerView: UIPickerView?
    
    @IBOutlet weak var thicknessTextField: UITextField?

    @IBOutlet weak var lineView: LineView?

    // MARK: - Object LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xTextField?.addTarget(self, action: #selector(textFieldDidChangeText(textField:)), for: .editingChanged)
        yTextField?.addTarget(self, action: #selector(textFieldDidChangeText(textField:)), for: .editingChanged)
        thicknessTextField?.addTarget(self, action: #selector(textFieldDidChangeText(textField:)), for: .editingChanged)

        lineView?.startPoint = CGPoint(x: lineView!.bounds.maxX/2.0, y: lineView!.bounds.maxY/2.0)
        lineView?.endPoint = CGPoint(x: lineView!.bounds.maxX, y: lineView!.bounds.maxY/2.0)
        lineView?.color = UIColor.black
        lineView?.thickness = 5.0
    }
    
    // MARK: - UIActions
    
    @IBAction func changeBarButtonTap(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            set(false, false, true, true)
        } else if sender.selectedSegmentIndex == 1 {
            set(false, false, true, true)
        } else if sender.selectedSegmentIndex == 2 {
            set(true, true, false, true)
        } else if sender.selectedSegmentIndex == 3 {
            set(true, true, true, false)
        }
    }
    
    @objc func textFieldDidChangeText(textField: UITextField) {
        if segmentedCotrnol!.selectedSegmentIndex == 0 || segmentedCotrnol!.selectedSegmentIndex == 1 {
            let x = xTextField?.text ?? ""
            let y = yTextField?.text ?? ""
            changeBarButtonItem?.isEnabled = !x.isEmpty && !y.isEmpty
        } else {
            let thickness = thicknessTextField?.text ?? ""
            changeBarButtonItem?.isEnabled = !thickness.isEmpty
        }
    }
    
    // MARK: - Private
    
    func set(_ xTxtFldIsHidden: Bool, _ yTxtFldIsHidden: Bool, _ clrPcrkrIsHidden: Bool, _ thcknsTxtFldIsHidden: Bool) {
        xTextField?.isHidden = xTxtFldIsHidden
        yTextField?.isHidden = yTxtFldIsHidden
        colorPickerView?.isHidden = clrPcrkrIsHidden
        thicknessTextField?.isHidden = thcknsTxtFldIsHidden
    }
}

