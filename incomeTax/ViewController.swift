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
        var grossIncome: Double = Double(grossIncomeTextfield.text!)!/10000
        var deduction: Double = Double(deductionTextfield.text!)!/10000
        var income: Double = Double(grossIncomeTextfield.text!)!/10000 - Double(deductionTextfield.text!)!/10000
        let incomeShow = Int(income*10000)
        taxedIncome.text = "\(incomeShow)"
        let thresholds: [Double]=[54,67,121,211]
        let rates=[0.05,0.12,0.2,0.3,0.4]
        for i in 0..<thresholds.count{
            if income <= thresholds[i]{
                tax += income * rates[i]
                income = 0
                let taxRate = Int(rates[i]*100)
                taxRateTextfield.text = "\(taxRate)"
                break
            }else{
                tax += thresholds[i]*rates[i]
                income -= thresholds[i]
                taxRateTextfield.text = "40"
            }
        }
        tax += income * rates[(rates.count)-1]
        let taxInt = Int(tax*10000)
        taxResultTextfield.text = " \(taxInt)"
        
    }
    
     override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        deductSegmentControl.selectedSegmentIndex = 0
        deductionTextfield.text = "320000"
        grossIncomeTextfield.text = ""
        taxedIncome.text = ""
        taxRateTextfield.text = ""
        taxResultTextfield.text = ""
        }
    
    @IBAction func calculateTax(_ sender: Any) {
        var grossIncome = Double(grossIncomeTextfield.text!)
        var deduction = Double(deductionTextfield.text!)
        if grossIncome != nil, deduction != nil,  Double(grossIncomeTextfield.text!)! - Double(deductionTextfield.text!)! >= 0{
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
            deductionTextfield.text = "320000"
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
