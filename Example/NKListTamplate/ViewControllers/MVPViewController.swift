//
//  MVPViewController.swift
//  NKListTamplate_Example
//
//  Created by Nick Kopilovskii on 7/3/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import NKListTamplate

class MVPViewController: NKListViewController {
  
  @IBOutlet weak var tableView: UITableView?
  
  lazy var presenter = Presenter(self)
  
  override var tableViewConfigurator: NKListConfigurator? {
    return presenter
  }
  
  override var contentTableView: UITableView? {
    return tableView
  }
}


class Presenter {
  weak var _viewer: NKListViewable?
  
  var viewModels: [NKAnyViewModel] = [  FirstCellViewModel(),
                                        SecondCellViewModel(),
                                        ThirdCellViewModel(),
                                        ThirdCellViewModel(),
                                        FirstCellViewModel(),
                                        ThirdCellViewModel(),
                                        SecondCellViewModel(),
                                        SecondCellViewModel(),
                                        ThirdCellViewModel(),
                                        ThirdCellViewModel(),
                                        FirstCellViewModel(),
                                        ThirdCellViewModel(),
                                        ThirdCellViewModel() ]
  
  init(_ viewer: NKListViewable) {
    _viewer = viewer
  }
}

extension Presenter: NKListConfigurator {
  var viewer: NKListViewable? {
    return _viewer
  }
  
  var isRefreshable: Bool {
    return false
  }
  
  var refreshTitle: String? {
    return nil
  }
  
  var cellViewModelTypes: [NKAnyViewModel.Type] {
    return [ FirstCellViewModel.self,
            SecondCellViewModel.self,
            ThirdCellViewModel.self ]
  }
  
  var headerViewModelTypes: [NKAnyViewModel.Type]? {
    return nil
  }
  
  var footerViewModelTypes: [NKAnyViewModel.Type]? {
    return nil
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
