//
//  ViewController.swift
//  LineView
//
//  Created by Damon Cricket on 17.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var changeBarButtonItem: UIBarButtonItem?
    
    @IBOutlet weak var segmentedCotrnol: UISegmentedControl?
    
    @IBOutlet weak var xTextField: UITextField?
    @IBOutlet weak var yTextField: UITextField?

    @IBOutlet weak var colorPickerView: UIPickerView?
    
    @IBOutlet weak var thicknessTextField: UITextField?

    @IBOutlet weak var lineView: LineView?
    
    var colorsAttributedString: [NSAttributedString] = [
        NSAttributedString(string: "black", attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 15.0)]),
        NSAttributedString(string: "blue", attributes: [.foregroundColor: UIColor.blue, .font: UIFont.systemFont(ofSize: 15.0)]),
        NSAttributedString(string: "gray", attributes: [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 15.0)])
    ]

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
        if segmentedCotrnol?.selectedSegmentIndex == 0 {
            let startPoint = CGPoint(x: xTextField!.cgFloat(), y: yTextField!.cgFloat())
            let animation = CABasicAnimation(keyPath: "startPoint")
            animation.fromValue = NSValue(cgPoint: lineView!.startPoint)
            animation.toValue = NSValue(cgPoint: startPoint)
            animation.duration = 0.5
            lineView?.layer.add(animation, forKey: "startPoint")
            lineView?.startPoint = startPoint
        } else if segmentedCotrnol?.selectedSegmentIndex == 1 {
            let endPoint = CGPoint(x: xTextField!.cgFloat(), y: yTextField!.cgFloat())
            let animation = CABasicAnimation(keyPath: "endPoint")
            animation.fromValue = NSValue(cgPoint: lineView!.endPoint)
            animation.toValue = NSValue(cgPoint: endPoint)
            animation.duration = 0.5
            lineView?.layer.add(animation, forKey: "endPoint")
            lineView?.endPoint = endPoint
        } else if segmentedCotrnol?.selectedSegmentIndex == 2 {
            let attributedString = colorsAttributedString[colorPickerView!.selectedRow(inComponent: 0)]
            let color = attributedString.attribute(.foregroundColor, at: 0, effectiveRange: nil) as! UIColor
            let animation = CABasicAnimation(keyPath: "color")
            animation.fromValue = lineView!.color.cgColor
            animation.toValue = color.cgColor
            animation.duration = 0.5
            lineView?.layer.add(animation, forKey: "color")
            lineView?.color = color
        } else if segmentedCotrnol?.selectedSegmentIndex == 3 {
            let thickness = thicknessTextField!.cgFloat()
            let animation = CABasicAnimation(keyPath: "thickness")
            animation.fromValue = lineView!.thickness
            animation.toValue = thickness
            animation.duration = 0.5
            lineView?.layer.add(animation, forKey: "thickness")
            lineView?.thickness = thickness
        }
    }
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            thicknessTextField?.text = ""
            updateChangeButton()
            set(false, false, true, true)
        } else if sender.selectedSegmentIndex == 1 {
            xTextField?.text = ""
            yTextField?.text = ""
            thicknessTextField?.text = ""
            updateChangeButton()
            set(false, false, true, true)
        } else if sender.selectedSegmentIndex == 2 {
            xTextField?.text = ""
            yTextField?.text = ""
            thicknessTextField?.text = ""
            updateChangeButton()
            set(true, true, false, true)
        } else if sender.selectedSegmentIndex == 3 {
            xTextField?.text = ""
            yTextField?.text = ""
            updateChangeButton()
            set(true, true, true, false)
        }
    }
    
    @IBAction func tapGestureRecognizer(sender: UIGestureRecognizer) {
        xTextField?.resignFirstResponder()
        yTextField?.resignFirstResponder()
        thicknessTextField?.resignFirstResponder()
    }
    
    @objc func textFieldDidChangeText(textField: UITextField) {
        updateChangeButton()
    }
    
    // MARK: - Private
    
    func set(_ xTxtFldIsHidden: Bool, _ yTxtFldIsHidden: Bool, _ clrPcrkrIsHidden: Bool, _ thcknsTxtFldIsHidden: Bool) {
        xTextField?.isHidden = xTxtFldIsHidden
        yTextField?.isHidden = yTxtFldIsHidden
        colorPickerView?.isHidden = clrPcrkrIsHidden
        thicknessTextField?.isHidden = thcknsTxtFldIsHidden
    }
    
    func updateChangeButton() {
        if segmentedCotrnol!.selectedSegmentIndex == 0 || segmentedCotrnol!.selectedSegmentIndex == 1 {
            let x = xTextField?.text ?? ""
            let y = yTextField?.text ?? ""
            changeBarButtonItem?.isEnabled = !x.isEmpty && !y.isEmpty
        } else {
            let thickness = thicknessTextField?.text ?? ""
            changeBarButtonItem?.isEnabled = !thickness.isEmpty
        }
    }
    
    // MARK: - UIPickerViewDataSource / UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorsAttributedString.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return colorsAttributedString[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeBarButtonItem?.isEnabled = true
    }
}

// MARK: - Extensions

extension UITextField {

    func cgFloat() -> CGFloat {
        return CGFloat(double())
    }
    
    func double() -> Double {
        return isText() ? ((text! as NSString).replacingOccurrences(of: ",", with: ".") as NSString).doubleValue: 0.0
    }
    
    func isText() -> Bool {
        return text != nil && !text!.isEmpty
    }
}
