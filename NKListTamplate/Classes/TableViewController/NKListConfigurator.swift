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
  
  var cellViewModelTypes: [NKAnyViewModel.Type] { get }
  var headerViewModelTypes: [NKAnyViewModel.Type]? { get }
  var footerViewModelTypes: [NKAnyViewModel.Type]? { get }
  
  var numberOfSections: Int { get }
  
  func numberOfRows(in section: Int) -> Int
  func cellViewModel(for indexPath: IndexPath) -> NKAnyViewModel?
  func headerViewModel(for section: Int) -> NKAnyViewModel?
  func footerViewModel(for section: Int) -> NKAnyViewModel?
  
  func didSelectItem(at indexPath: Int)
  
  func didMakeRefresh()
}
