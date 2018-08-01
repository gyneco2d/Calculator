//
//  ViewController.swift
//  classCalculator
//
//  Created by 池田素規 on 2016/08/18.
//  Copyright © 2016年 Te+A. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OperatorViewDelegate {
    
    fileprivate var myLabel : UILabel!
    fileprivate var process : UILabel!
    
    var vertical = 0
    var horizontal = 0
    
    var result = 0
    var one = 0
    var two = 0
    var digits = 10
    var elementX = 0
    var elementY = 0
    var operation = 0
    var formula = "formula"
    var operating = " "
    var decimal = 0.0
    var judge = 0  //elementYを使用しているか
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureTable()
        
        //解ディスプレイ--------------------------------------
        myLabel = UILabel(frame: CGRect(x: 0, y: 68, width: 320, height: 100))
        myLabel.backgroundColor = UIColor.black
        myLabel.text = "0"
        myLabel.textAlignment = NSTextAlignment.right
        myLabel.textColor = UIColor.white
        myLabel.font = UIFont.systemFont(ofSize: 50)
        self.view.addSubview(myLabel)
        
        
        //式ディスプレイ--------------------------------------
        process = UILabel(frame: CGRect(x: 0, y: 20, width: 320, height: 48))
        process.backgroundColor = UIColor.lightGray
        process.text = " "
        process.textAlignment = NSTextAlignment.right
        process.font = UIFont.systemFont(ofSize: 30)
        process.lineBreakMode = NSLineBreakMode.byTruncatingHead
        self.view.addSubview(process)
        
        
        //数字----------------------------------------------
        for i in 1...9 {
            let num = UIButton(type: .custom)
            if i % 3 != 0 {
                horizontal = 80 * ((i % 3) - 1)
            } else {
                horizontal = 80 * 2
            }
            num.frame = CGRect(x:horizontal, y:408 - vertical, width:80, height:80)
            num.backgroundColor = UIColor.gray
            num.setTitle("\(i)", for: UIControlState())
            num.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            num.addTarget(self, action: #selector(ViewController.makeElement(_:)), for: .touchDown)
            num.tag = i
            self.view.addSubview(num)
            
            if i % 3 == 0 {
                vertical += 80
                horizontal = 0
            }
        }
        
        let zero = UIButton(type: .custom)
        zero.frame = CGRect(x:0, y:488, width:160, height:80)
        zero.backgroundColor = UIColor.gray
        zero.setTitle("0", for: UIControlState())
        zero.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        zero.addTarget(self, action: #selector(ViewController.makeElement(_:)), for: .touchDown)
        zero.tag = 0
        self.view.addSubview(zero)
        
        
        //小数点---------------------------------------------
        let point = UIButton(type: .custom)
        point.frame = CGRect(x:160, y:488, width:80, height:80)
        point.backgroundColor = UIColor.red
        point.setTitle("未実装", for: UIControlState())
        point.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        point.addTarget(self, action: #selector(ViewController.makeElement(_:)),for: .touchDown)
        point.tag = 17
        self.view.addSubview(point)
    }

    
    //数字入力-----------------------------------------------
    func makeElement(_ sender: UIButton) {
        if operation == 0 {
            if sender.tag <= 9 {
                if one < 999999999 {
                    one = elementX * digits + sender.tag
                    elementX = one
                    result = elementX
                    formula = "\(elementX)"
                }
            }
        } else if operation != 0 {
            if sender.tag <= 9 {
                if two < 999999999 {
                    two = elementY * digits + sender.tag
                    elementY = two
                    result = elementY
                    judge = 1
                    formula += "\(sender.tag)"
                }
            }
        }
        process.text = "\(formula)"
        myLabel.text = "\(result)"
    }
    
    //演算子-------------------------------------------------
    func configureTable() {
        let operatorView = OperatorView()
        operatorView.frame = CGRect(x: 0, y: 168, width: 320, height: 400)
        operatorView.backgroundColor = UIColor.lightGray
        operatorView.delegate = self
        self.view.addSubview(operatorView)
    }
    
    
    //計算--------------------------------------------------
    func operatorViewDidSelect(_ type: OperationType) {
        
        switch type {
        case .ac:
            result = 0
            one = 0
            two = 0
            digits = 10
            elementX = 0
            elementY = 0
            operation = 0
            formula = " "
            operating = " "
            decimal = 0.0
            judge = 0
        case .c:
            if judge == 0 {
                result = 0
                one = 0
                two = 0
                digits = 10
                elementX = 0
                elementY = 0
                operation = 0
                formula = " "
                operating = " "
                decimal = 0.0
            } else {
                two = 0
                elementY = 0
                operation = 0
                result = elementX
                formula = formula.substring(to: (formula.range(of: "\(operating)")?.lowerBound)!)
                judge = 0
            }
        case .plusminus:
            if judge == 0 {
                elementX *= -1
                result = elementX
                formula = "\(elementX)"
            } else {
                elementY *= -1
                result = elementY
                formula = formula.substring(to: (formula.range(of: "\(operating)")?.upperBound)!)
                formula += "\(elementY)"
            }
        case .division:
            if judge == 0 {
                
                operation = 11
                
                operating = " ÷ "
                formula += operating
            } else {
                
                operating = " ÷ "
                formula += operating
                
                switch operation {
                case 11:
                    result = elementX / elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 12:
                    result = elementX * elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 13:
                    result = elementX - elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 14:
                    result = elementX + elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                default:
                    break
                }
                
                operation = 11
                
            }
        case .multiplication:
            if judge == 0 {
                
                operation = 12
                
                operating = " × "
                formula += operating
            } else {
                
                operating = " × "
                formula += operating
                
                switch operation {
                case 11:
                    result = elementX / elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 12:
                    result = elementX * elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 13:
                    result = elementX - elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 14:
                    result = elementX + elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                default:
                    break
                }
                
                operation = 12
                
            }
        case .subtraction:
            if judge == 0 {
                
                operation = 13
                
                operating = " - "
                formula += operating
            } else {
                
                operating = " - "
                formula += operating
                
                switch operation {
                case 11:
                    result = elementX / elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 12:
                    result = elementX * elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 13:
                    result = elementX - elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 14:
                    result = elementX + elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                default:
                    break
                }
                
                operation = 13
                
            }
        case .addition:
            if judge == 0 {
                
                operation = 14
                
                operating = " + "
                formula += operating
            } else {
                
                operating = " + "
                formula += operating
                
                switch operation {
                case 11:
                    result = elementX / elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 12:
                    result = elementX * elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 13:
                    result = elementX - elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                case 14:
                    result = elementX + elementY
                    elementX = result
                    elementY = 0
                    judge = 0
                default:
                    break
                }
                
                operation = 14
                
            }
        case .equal:
            if judge != 0 {
                switch operation {
                case 11:
                    result = elementX / elementY
                    elementX = result
                    elementY = 0
                    operation = 0
                case 12:
                    result = elementX * elementY
                    elementX = result
                    elementY = 0
                    operation = 0
                case 13:
                    result = elementX - elementY
                    elementX = result
                    elementY = 0
                    operation = 0
                case 14:
                    result = elementX + elementY
                    elementX = result
                    elementY = 0
                    operation = 0
                default:
                    break

                }
            }
        }
        
        process.text = "\(formula)"
        myLabel.text = "\(result)"
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

