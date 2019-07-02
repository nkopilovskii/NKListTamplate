//
//  UITableView.swift
//  RestaurentManagementTool
//
//  Created by Nick Kopilovskii on 2/11/19.
//  Copyright © 2019 Nick Kopilovskii. All rights reserved.
//

import UIKit

public extension UITableView {
  
  func dequeueReusableCell(with model: NKAnyViewModel, for indexPath: IndexPath) -> UITableViewCell {
    let identifier = String(describing: type(of: model).viewAnyType)
    let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    model.setupAny(view: cell)
    return cell
  }
  
  func registerCell(nibModels: [NKAnyViewModel.Type]) {
    nibModels.forEach {
      let identifier = String(describing: $0.viewAnyType)
      let nib = UINib(nibName: identifier, bundle: nil)
      register(nib, forCellReuseIdentifier: identifier)
    }
  }
  
  func dequeueReusableView(with model: NKAnyViewModel) -> UITableViewHeaderFooterView {
    let identifier = String(describing: type(of: model).viewAnyType)
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) else {
      return UITableViewHeaderFooterView()
    }
    model.setupAny(view: view)
    return view
  }
  
  func registerView(nibModels: [NKAnyViewModel.Type]) {
    nibModels.forEach {
      let identifier = String(describing: $0.viewAnyType)
      let nib = UINib(nibName: identifier, bundle: nil)
      register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
  }
  
}

