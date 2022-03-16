//
//  ViewController.swift
//  CalculatorPractice
//
//  Created by Chae_Haram on 2022/03/09.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var calculateFormulaLabel: UILabel!
    @IBOutlet weak var calculationResultLabel: UILabel!
    
    var formula: String = ""
    var oper: Operator = .plus
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    enum Operator: String {
        case plus = "+"
        case minus = "-"
        case multiple = "*"
        case divide = "/"
        case rem = "%"
    }
    
    func operation(a: Double, b: Double, op: Operator) -> Double {
        switch op {
        case .plus:
            return (a + b)
        case .minus:
            return (a - b)
        case .multiple:
            return (a * b)
        case .divide:
            return (a / b)
        case .rem:
            return a.truncatingRemainder(dividingBy: b)
        
        }
    }
    
    
    @IBAction func zeroButton(_ sender: UIButton) {
        formula.append("0")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func oneButton(_ sender: UIButton) {
        formula.append("1")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func twoButton(_ sender: UIButton) {
        formula.append("2")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func threeButton(_ sender: UIButton) {
        formula.append("3")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func fourButton(_ sender: UIButton) {
        formula.append("4")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func fiveButton(_ sender: UIButton) {
        formula.append("5")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func sixButton(_ sender: UIButton) {
        formula.append("6")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func sevenButton(_ sender: UIButton) {
        formula.append("7")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func eightButton(_ sender: UIButton) {
        formula.append("8")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func nineButton(_ sender: UIButton) {
        formula.append("9")
        calculateFormulaLabel.text = formula
    }
    
    @IBAction func plusButton(_ sender: UIButton) {
        formula.append("+")
        calculateFormulaLabel.text = formula
        oper = .plus
        
    }
    
    @IBAction func minusButton(_ sender: UIButton) {
        formula.append("-")
        calculateFormulaLabel.text = formula
        oper = .minus
        
    }
    
    @IBAction func multipleButton(_ sender: UIButton) {
        formula.append("*")
        calculateFormulaLabel.text = formula
        oper = .multiple
    }
    
    @IBAction func devideButton(_ sender: UIButton) {
        formula.append("/")
        calculateFormulaLabel.text = formula
        oper = .divide
    }
    
    @IBAction func remButton(_ sender: UIButton) {
        formula.append("%")
        calculateFormulaLabel.text = formula
        oper = .rem
    }
    
    @IBAction func allClearButton(_ sender: UIButton) {
        calculateFormulaLabel.text = "0"
        calculationResultLabel.text = "0"
        formula = ""
        
    }
    
    @IBAction func equalButton(_ sender: UIButton) {
//        num2 = Double(calculationResultLabel.text!)!
//        result = String(operation(a: num1, b: num2, op: oper))
//        calculationResultLabel.text = result

        // for, while, foreach중 "foreach" <- 문자열이랑 같이 쓰면 좋음
        // 문자열 -> 배열 -> for
        var numbers: [Double] = []
        var temp: String = "" // 연산자를 만나면 numbers에 넣어주고, temp는 비우고
        var op: Operator?
        
        // 연산기호는 letter가 아니다.
        formula.forEach { char in
            if temp.isEmpty, Operator.init(rawValue: String(char)) == nil {
                temp.append(char)
            } else {
                if let oper = Operator.init(rawValue: String(char)) {
                        if let number = Double(temp), op == nil {
                        numbers.append(number)
                    }
                    op = oper
                    temp = ""
                } else {
                    if Operator.init(rawValue: String(char)) == nil {
                        temp.append(char)
                    }
                }
            }
            
        }
        if let lastNumber = Double(temp) {
            numbers.append(lastNumber)
        } else{
         print("올바르지 않은 입력입니다.")
        }
        guard let op = op else { return }
        let result = operation(a: numbers[0], b: numbers[1], op: op)
        calculateFormulaLabel.text = "\(result)"
        calculationResultLabel.text = " = \(result)"
        
        formula = "\(result)"
    }
    
    @IBAction func positiveNegativeButton(_ sender: UIButton) {
        //calculationResultLabel.text = "-\(result)"
    }
    
    @IBAction func dotButton(_ sender: UIButton) {

    }

}

