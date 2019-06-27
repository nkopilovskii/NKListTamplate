//
//  UICollectionView.swift
//  RestaurentManagementTool
//
//  Created by Nick Kopilovskii on 2/11/19.
//  Copyright © 2019 Nick Kopilovskii. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func dequeueReusableCell(with model: AnyViewModel, for indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: type(of: model).viewAnyType)
    let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    model.setupAny(view: cell)
    return cell
  }
  
  func register(nibModels: [AnyViewModel.Type]) {
    nibModels.forEach {
      let identifier = String(describing: $0.viewAnyType)
      let nib = UINib(nibName: identifier, bundle: nil)
      register(nib, forCellWithReuseIdentifier: identifier)
    }
  }
  
  func dequeueReusableHeaderView(with model: AnyViewModel, for indexPath: IndexPath) -> UICollectionReusableView {
    let identifier = String(describing: type(of: model).viewAnyType)
    let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath)
    model.setupAny(view: header)
    return header
  }
  
  func dequeueReusableFooterView(with model: AnyViewModel, for indexPath: IndexPath) -> UICollectionReusableView {
    let identifier = String(describing: type(of: model).viewAnyType)
    let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath)
    model.setupAny(view: header)
    return header
  }
  
  func registerHeaderView(nibModels: [AnyViewModel.Type]) {
    nibModels.forEach {
      let identifier = String(describing: $0.viewAnyType)
      let nib = UINib(nibName: identifier, bundle: nil)
      register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }
  }
  
  func registerFooterView(nibModels: [AnyViewModel.Type]) {
    nibModels.forEach {
      let identifier = String(describing: $0.viewAnyType)
      let nib = UINib(nibName: identifier, bundle: nil)
      register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }
  }
  
}

