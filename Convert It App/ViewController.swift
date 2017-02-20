//
//  ViewController.swift
//  The $125 Million App
//
//  Created by Nick on 2/5/17.
//  Copyright © 2017 Nick Ryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var resultMessage: UITextField!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    
    @IBOutlet weak var posNegController: UISegmentedControl!
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    var toUnits = ""
    var conversionString = ""
    var fromUnits = ""
    var outputString = ""
    var rowSelected = 0
    
    struct Formula {
        var conversionString: String
        var formula: (Double) -> Double
    }
    
    let formulasArray = [Formula(conversionString: "miles to kilometers", formula: {$0 / 0.62137}),
                        Formula(conversionString: "kilometers to miles", formula: {$0 * 0.62137}),
                        Formula(conversionString: "feet to meters", formula: {$0 / 3.2808}),
                        Formula(conversionString: "meters to feet", formula: {$0 * 3.2808}),
                        Formula(conversionString: "yards to meters", formula: {$0 / 1.0936}),
                        Formula(conversionString: "meters to yards", formula: {$0 * 1.0936}),
                        Formula(conversionString: "inches to centimeters", formula: {$0 / 0.39370}),
                        Formula(conversionString: "centimeters to inches", formula: {$0 * 0.39370}),
                        Formula(conversionString: "celsius to farenheit", formula: {$0 * 9 / 5 + 32}),
                        Formula(conversionString: "farenheit to celsius", formula: {($0 - 32) * 5 / 9}),
                        Formula(conversionString: "quarts to liters", formula: {$0 / 1.05669}),
                        Formula(conversionString: "liters to quarts", formula: {$0 * 1.05669})]
    
    func calculateConversion() {
        var inputValue = textInput.text
        var outputValue = 0.0
        if let inputValue = Double(textInput.text!) {
            outputValue = formulasArray[rowSelected].formula(inputValue)
        } else {
            self.showAlert(title: "Error", message: "Please enter a valid number. Not an empty string, no commas, symbols, or non-numeric characters")
            }
        if decimalSegment.selectedSegmentIndex != 3{
        outputString = String(format: "%." + String(decimalSegment.selectedSegmentIndex+1) + "f",outputValue)
        } else {
            outputString = String(outputValue)
        }
        
    resultMessage.text = "\(textInput.text!) \(fromUnits) equals \(outputString) \(toUnits)"
    }
    
    func assignUnits() {
        let unitsArray = conversionString.components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        fromUnitsLabel.text = fromUnits
        toUnits = unitsArray[1]
        resultMessage.text = toUnits
    }
    
    
//MARK:- Delegates and Data Sources
    override func viewDidLoad() {
        formulaPicker.dataSource = self
        formulaPicker.delegate = self
        super.viewDidLoad()
        textInput.delegate = self
        textInput.becomeFirstResponder()
        conversionString = "miles to kilometers"
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
textInput.resignFirstResponder()
        return true
    }
//MARK:- Required functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formulasArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formulasArray[row].conversionString
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if conversionString == "farenheit to celsius" || conversionString == "celsius to farenheit"  {
            posNegController.isHidden = false
        } else {
            posNegController.isHidden = true
            textInput.text = textInput.text!.replacingOccurrences(of: "-", with: "")
            posNegController.selectedSegmentIndex = 0

        }
        rowSelected = row
        conversionString = formulasArray[row].conversionString
        assignUnits()
        if textInput.text?.characters.count != 0 {
            calculateConversion()
    }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil
        )
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK:- IB Actions

    @IBAction func convertButton(_ sender: UIButton) {
        calculateConversion()
    }
 
    @IBAction func decimalSelected(_ sender: UISegmentedControl) {
        calculateConversion()
        
    }
 
    @IBAction func posNegAction(_ sender: UISegmentedControl) {

        if posNegController.selectedSegmentIndex == 1 {
            textInput.text = "-" + textInput.text!
        } else {
        textInput.text = textInput.text!.replacingOccurrences(of: "-", with: "")
        posNegController.selectedSegmentIndex = 0
        }
        if textInput.text != "-" {
        calculateConversion()
    }
}
}
