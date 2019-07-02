//
//  AnyViewModel.swift
//  RestaurentManagementTool
//
//  Created by Nick Kopilovskii on 2/11/19.
//  Copyright © 2019 Nick Kopilovskii. All rights reserved.
//

import UIKit

public protocol NKAnyViewModel {
  static var viewAnyType: UIView.Type { get }
  func setupAny(view: UIView)
  func estimatedSize(in frame: CGRect) -> CGSize
}

public protocol ViewModel: NKAnyViewModel {
  associatedtype ViewType: UIView
  func setup(view: ViewType)
}

public extension ViewModel {
  static var viewAnyType: UIView.Type {
    return ViewType.self
  }
  
  func setupAny(view: UIView) {
    if let view = view as? ViewType {
      setup(view: view)
    } else {
      //TODO: Handle this
      assertionFailure("Error: \(#function) \(#file) \(#line)")
    }
  }
}
