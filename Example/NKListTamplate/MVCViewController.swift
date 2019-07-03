//
//  ViewController.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 06/27/2019.
//  Copyright (c) 2019 Nick Kopilovskii. All rights reserved.
//

import UIKit
import NKListTamplate

class MVCViewController: NKListViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override var tableViewConfigurator: NKListConfigurator? {
    return self
  }
  
  override var contentTableView: UITableView? {
    return tableView
  }
  
  var viewModels: [NKAnyViewModel] = [  FirstCellViewModel(),
                                        SecondCellViewModel(),
                                        ThirdCellViewModel(),
                                        FirstCellViewModel(),
                                        FirstCellViewModel(),
                                        FirstCellViewModel(),
                                        SecondCellViewModel(),
                                        SecondCellViewModel(),
                                        SecondCellViewModel(),
                                        ThirdCellViewModel(),
                                        FirstCellViewModel(),
                                        SecondCellViewModel(),
                                        ThirdCellViewModel() ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}


extension MVCViewController: NKListConfigurator {
  var viewer: NKListViewable? { return self }
  
  var isRefreshable: Bool { return true }
  
  var refreshTitle: String? { return nil }
  
  var cellViewModelTypes: [NKAnyViewModel.Type] {
    return [FirstCellViewModel.self, SecondCellViewModel.self, ThirdCellViewModel.self]
  }
  
  var headerViewModelTypes: [NKAnyViewModel.Type]? {
    return []
  }
  
  var footerViewModelTypes: [NKAnyViewModel.Type]? {
    return []
  }
  
  var numberOfSections: Int {
    return 1
  }
  
  func numberOfRows(in section: Int) -> Int {
    return viewModels.count
  }
  
  func cellViewModel(for indexPath: IndexPath) -> NKAnyViewModel? {
    return viewModels[indexPath.row]
  }
  
  func headerViewModel(for section: Int) -> NKAnyViewModel? {
    return nil
  }
  
  func footerViewModel(for section: Int) -> NKAnyViewModel? {
    return nil
  }
  
  func didSelectItem(at indexPath: Int) {
    
  }
  
  func didMakeRefresh() {
    
  }
  
  
}
