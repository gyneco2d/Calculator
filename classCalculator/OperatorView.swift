//
//  OperatorView.swift
//  classCalculator
//
//  Created by 池田素規 on 2016/08/19.
//  Copyright © 2016年 Te+A. All rights reserved.
//

import UIKit

enum OperationType : Int {
    case ac, c, plusminus, division, multiplication, subtraction, addition, equal
}

protocol OperatorViewDelegate {
    func operatorViewDidSelect(_ type: OperationType)
}

class OperatorView: UIView {
    
    
    //フィールド----------------------------------------------
    fileprivate var acBtn : UIButton
    fileprivate var clearBtn : UIButton
    fileprivate var plusMinusBtn : UIButton
    fileprivate var divisionBtn : UIButton
    fileprivate var multiplicationBtn : UIButton
    fileprivate var subtractionBtn : UIButton
    fileprivate var additionBtn : UIButton
    fileprivate var equalBtn : UIButton
    //    private var pointBtn : UIButton
    
    var delegate:OperatorViewDelegate?
    
    
    //イニシャライザ------------------------------------------
    override init(frame: CGRect) {
        
        acBtn = UIButton()
        clearBtn = UIButton()
        plusMinusBtn = UIButton()
        divisionBtn = UIButton()
        multiplicationBtn = UIButton()
        subtractionBtn  = UIButton()
        additionBtn  = UIButton()
        equalBtn = UIButton()
        //        pointBtn = UIButton()
        
        super.init(frame: frame)
        
        self.addSubview(acBtn)
        self.addSubview(clearBtn)
        self.addSubview(plusMinusBtn)
        self.addSubview(divisionBtn)
        self.addSubview(multiplicationBtn)
        self.addSubview(subtractionBtn)
        self.addSubview(additionBtn)
        self.addSubview(equalBtn)
        //        self.addSubview(pointBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //メソッド-----------------------------------------------
    override func layoutSubviews() {
        
        // AC ----------------------------------------------
        acBtn.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        acBtn.backgroundColor = UIColor.blue
        acBtn.setTitle("AC", for: UIControlState())
        acBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        acBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        acBtn.tag = OperationType.ac.rawValue
        
        // C -----------------------------------------------
        clearBtn.frame = CGRect(x: 80, y: 0, width: 80, height: 80)
        clearBtn.backgroundColor = UIColor.blue
        clearBtn.setTitle("C", for: UIControlState())
        clearBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        clearBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        clearBtn.tag = OperationType.c.rawValue
        
        // +/- ---------------------------------------------
        plusMinusBtn.frame = CGRect(x: 160, y: 0, width: 80, height: 80)
        plusMinusBtn.backgroundColor = UIColor.blue
        plusMinusBtn.setTitle("+/-", for: UIControlState())
        plusMinusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        plusMinusBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        plusMinusBtn.tag = OperationType.plusminus.rawValue
        
        //論理演算子-----------------------------------------
        // ÷
        divisionBtn.frame = CGRect(x:240, y:0, width:80, height:80)
        divisionBtn.backgroundColor = UIColor.orange
        divisionBtn.setTitle("÷", for: UIControlState())
        divisionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        divisionBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        divisionBtn.tag = OperationType.division.rawValue
        
        // ×
        multiplicationBtn.frame = CGRect(x:240, y:80, width:80, height:80)
        multiplicationBtn.backgroundColor = UIColor.orange
        multiplicationBtn.setTitle("×", for:UIControlState())
        multiplicationBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        multiplicationBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        multiplicationBtn.tag = OperationType.multiplication.rawValue
        
        // -
        subtractionBtn.frame = CGRect(x:240, y:160, width:80, height:80)
        subtractionBtn.backgroundColor = UIColor.orange
        subtractionBtn.setTitle("-", for: UIControlState())
        subtractionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        subtractionBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        subtractionBtn.tag = OperationType.subtraction.rawValue
        
        // +
        additionBtn.frame = CGRect(x:240, y:240, width:80, height:80)
        additionBtn.backgroundColor = UIColor.orange
        additionBtn.setTitle("+", for: UIControlState())
        additionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        additionBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        additionBtn.tag = OperationType.addition.rawValue
        
        // =
        equalBtn.frame = CGRect(x:240, y:320, width:80, height:80)
        equalBtn.backgroundColor = UIColor.orange
        equalBtn.setTitle("=", for: UIControlState())
        equalBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        equalBtn.addTarget(self, action: #selector(OperatorView.tappedOperator(_:)), for: .touchDown)
        equalBtn.tag = OperationType.equal.rawValue
        
    }
    
    func tappedOperator(_ sender: UIButton) {
        let type = OperationType(rawValue: sender.tag)!
        self.delegate?.operatorViewDidSelect( type )
    }
    
}







    
