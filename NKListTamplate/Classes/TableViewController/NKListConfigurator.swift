//
//  NKTableViewConfigurator.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 6/27/19.
//

import Foundation

public protocol NKListConfigurator {
  
  var viewer: NKListViewable? { get }
  
  var isRefreshable: Bool { get }
  var refreshTitle: String? { get }
  
  var cellViewModelTypes: [AnyViewModel.Type] { get }
  var headerViewModelTypes: [AnyViewModel.Type]? { get }
  var footerViewModelTypes: [AnyViewModel.Type]? { get }
  
  var numberOfSections: Int { get }
  
  func numberOfRows(in section: Int) -> Int
  func cellViewModel(for indexPath: IndexPath) -> AnyViewModel?
  func headerViewModel(for section: Int) -> AnyViewModel?
  func footerViewModel(for section: Int) -> AnyViewModel?
  
  func didSelectItem(at indexPath: Int)
  
  func didMakeRefresh()
}
