//
//  ViewController.swift
//  incomeTax
//
//  Created by Bernice TSAI on 2020/8/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var taxResultTextfield: UITextField!
    @IBOutlet weak var deductionTextfield: UITextField!
    @IBOutlet weak var grossIncomeTextfield: UITextField!
    @IBOutlet weak var taxRateTextfield: UITextField!
    @IBOutlet weak var taxedIncome: UITextField!
    @IBOutlet weak var deductSegmentControl: UISegmentedControl!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder();
    return true
    }
    
    func calculateIncomeTax(){
        
        var tax: Double = 0
        var grossIncome: Double = Double(grossIncomeTextfield.text!)!
        var deduction: Double = Double(deductionTextfield.text!)!
        var income: Double = Double(grossIncomeTextfield.text!)! - Double(deductionTextfield.text!)!
        let incomeString = String(format: "%.4f", income)
        taxedIncome.text = "\(incomeString)"
        let thresholds: [Double]=[54,67,121,211]
        let rates=[0.05,0.12,0.2,0.3,0.4]
        for i in 0..<thresholds.count{
            if income <= thresholds[i]{
                tax += income * rates[i]
                income = 0
                let taxRate = rates[i]*100
                taxRateTextfield.text = "\(taxRate)"
                break
            }else{
                tax += thresholds[i]*rates[i]
                income -= thresholds[i]
                taxRateTextfield.text = "40"
            }
        }
        tax += income * rates[(rates.count)-1]
        let taxString = String(format:"%.4f" ,tax)
        taxResultTextfield.text = " \(taxString)"
        
    }
    
     override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        deductSegmentControl.selectedSegmentIndex = 0
        deductionTextfield.text = "32"
        grossIncomeTextfield.text = ""
        taxedIncome.text = ""
        taxRateTextfield.text = ""
        taxResultTextfield.text = ""
        }
    
    @IBAction func calculateTax(_ sender: Any) {
        if grossIncomeTextfield != nil, deductionTextfield != nil, Double(grossIncomeTextfield.text!)! - Double(deductionTextfield.text!)! >= 0{
            textFieldShouldReturn(grossIncomeTextfield)
            textFieldShouldReturn(deductionTextfield)
            calculateIncomeTax()
        }else {
            taxedIncome.text = "0"
            taxRateTextfield.text = ""
            taxResultTextfield.text = "無需繳稅"
        }
        }
        
    @IBAction func ChangeDeductStyle(_ sender: UISegmentedControl) {
        let index = deductSegmentControl.selectedSegmentIndex
        switch index {
        case 0: // 標準扣除
            deductionTextfield.text = "32"
        case 1:// 列舉扣除
            deductionTextfield.text = ""
            deductionTextfield.isEnabled = true

        default:
            return
        }
    }
    @IBAction func clearEntry(_ sender: UIButton) {
        viewDidLoad()
    }
}
