//
//  ViewController.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 06/27/2019.
//  Copyright (c) 2019 Nick Kopilovskii. All rights reserved.
//

import UIKit
import NKListTamplate

class MVCViewController: UITableViewController, NKListViewable {
  
  var tableViewConfigurator: NKListConfigurator? {
    return self
  }
  
  var contentTableView: UITableView? {
    return tableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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
  
  var cellViewModelTypes: [AnyViewModel.Type] {
    return []
  }
  
  var headerViewModelTypes: [AnyViewModel.Type]? {
    return []
  }
  
  var footerViewModelTypes: [AnyViewModel.Type]? {
    return []
  }
  
  var numberOfSections: Int {
    return 0
  }
  
  func numberOfRows(in section: Int) -> Int {
    return 0
  }
  
  func cellViewModel(for indexPath: IndexPath) -> AnyViewModel? {
    return nil
  }
  
  func headerViewModel(for section: Int) -> AnyViewModel? {
    return nil
  }
  
  func footerViewModel(for section: Int) -> AnyViewModel? {
    return nil
  }
  
  func didSelectItem(at indexPath: Int) {
    
  }
  
  func didMakeRefresh() {
    
  }
  
  
}
