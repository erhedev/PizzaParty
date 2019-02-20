//
//  PizzeriaCell.swift
//  PizzaParty
//
//  Created by Erik Hede on 2019-02-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import Foundation

protocol PizzeriaCellDelegate {
    func didTapSeeMenu(id: Int)
}

class PizzeriaCell {
    // class for tableview cell
    
    var delegate: PizzeriaCellDelegate?
    
    
}
