//
//  ViewController.swift
//  The $125 Million App
//
//  Created by Nick on 2/5/17.
//  Copyright © 2017 Nick Ryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var resultMessage: UITextField!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    
    var formulasArray = ["miles to kilometers", "kilometers to miles", "feet to meters", "yards to meters", "meters to feet", "meters to yards"]
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
        conversionString = "miles to kilometers"
        // Do any additional setup after loading the view, typically from a nib.
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
        
        let unitsArray = formulasArray[row].components(separatedBy: " to ")
        conversionString = formulasArray[row]
        
        fromUnits = unitsArray[0]
        fromUnitsLabel.text = fromUnits
        toUnits = unitsArray[1]
        resultMessage.text = toUnits
        calculateConversion()
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
 

}
