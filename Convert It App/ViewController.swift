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
    
    var formulasArray = ["miles to kilometers", "kilometers to miles", "feet to meters", "yards to meters", "meters to feet", "meters to yards", "inches to centimeters", "centimeters to inches", "farenheit to celsius", "celsius to farenheit", "quarts to liters", "liters to quarts"]
    var toUnits = ""
    var conversionString = ""
    var fromUnits = ""
    var outputString = ""
    
    func calculateConversion() {
        var inputValue = textInput.text
        var outputValue = 0.0
        
        if let inputValue = Double(textInput.text!) {
            switch conversionString {
            case "miles to kilometers":
                outputValue = inputValue / 0.62137
            case "kilometers to miles":
                outputValue = inputValue * 0.62137
            case "feet to meters":
                outputValue = inputValue / 3.2808
            case "meters to feet":
                outputValue = inputValue * 3.2808
            case "yards to meters":
                outputValue = inputValue / 1.0936
            case "meters to yards":
                outputValue = inputValue * 1.0936
            case "inches to centimeters":
                outputValue = inputValue / 0.39370
            case "centimeters to inches":
                outputValue = inputValue * 0.39370
            case "farenheit to celsius":
                outputValue = (inputValue - 32) * 5 / 9
            case "celsius to farenheit":
                outputValue = inputValue * 9 / 5 + 32
            case "quarts to liters":
                outputValue = inputValue / 1.05669
            case "liters to quarts":
                outputValue = inputValue * 1.05669
            default:
                showAlert()}
        } else {
            self.showAlert()
            }
        if decimalSegment.selectedSegmentIndex != 3{
        outputString = String(format: "%." + String(decimalSegment.selectedSegmentIndex+1) + "f",outputValue)
        } else {
            outputString = String(outputValue)
        }
        
    resultMessage.text = "\(textInput.text!) \(fromUnits) equals \(outputString) \(toUnits)"
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
        return formulasArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if conversionString == "farenheit to celsius" || conversionString == "celsius to farenheit"  {
            posNegController.isHidden = false
        } else {
            posNegController.isHidden = true
            textInput.text = textInput.text!.replacingOccurrences(of: "-", with: "")
            posNegController.selectedSegmentIndex = 0

        }
        let unitsArray = formulasArray[row].components(separatedBy: " to ")
        conversionString = formulasArray[row]
        
        fromUnits = unitsArray[0]
        fromUnitsLabel.text = fromUnits
        toUnits = unitsArray[1]
        resultMessage.text = toUnits
        if textInput.text?.characters.count != 0 {
            calculateConversion()
    }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Entry Error", message: "Please enter a valid number. Not an empty string, no commas, symbols, or non-numeric characters", preferredStyle: .alert)
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
