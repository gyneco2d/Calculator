//
//  OperatorButton.swift
//  classCalculator
//
//  Created by 池田素規 on 2016/08/18.
//  Copyright © 2016年 Te+A. All rights reserved.
//

import UIKit

enum OperationType : Int {
    case AC, C, PLUSMINUS, DIVISION, MULTIPLICATION, SUBTRACTION, ADDITION
}

protocol OperatorButtonDelegate {
    func operateDidSelect(type: OperationType)
}

class OperationButton: UIView {
    
    //フィールド------------------------------------
    private var acBtn : UIButton
    private var cBtn : UIButton
    private var divisionBtn : UIButton
    private var multiplicationBtn : UIButton
    private var subtractionBtn : UIButton
    private var additionBtn : UIButton
    
    var delegate:OperationButtonDelegate?
}