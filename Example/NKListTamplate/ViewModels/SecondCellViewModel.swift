//
//  SecondCellViewModel.swift
//  NKListTamplate_Example
//
//  Created by Nick Kopilovskii on 7/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import NKAnyViewModel

class SecondCellViewModel: NKViewModel {
  
  func setup(view: Cell) {
    view.lblText?.text = String(describing: type(of: self))
  }
}

