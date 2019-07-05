//
//  ThirdCellViewModel.swift
//  NKListTamplate_Example
//
//  Created by Nick Kopilovskii on 7/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import NKAnyViewModel

class ThirdCellViewModel: NKViewModel {
  
  func setup(view: AnotherCell) {
    view.lblText?.text = String(describing: type(of: self))
  }
}

