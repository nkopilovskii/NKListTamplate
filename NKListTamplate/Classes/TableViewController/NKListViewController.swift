//
//  NKListViewController.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 7/3/19.
//

import UIKit

//MARK: - NKListViewController class
open class NKListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NKListViewable {
  
  open var tableViewConfigurator: NKListConfigurator? { return nil }
  open var contentTableView: UITableView? { return nil }
  
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    configurateTableView()
  }
  
  open func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewConfigurator?.numberOfSections ?? 0
  }
  
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewConfigurator?.numberOfRows(in: section) ?? 0
  }
  
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = tableViewConfigurator?.cellViewModel(for: indexPath) else { return UITableViewCell() }
    return tableView.dequeueReusableCell(with: viewModel, for: indexPath)
  }
  
  open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let viewModel = tableViewConfigurator?.headerViewModel(for: section) else { return nil }
    return tableView.dequeueReusableView(with: viewModel)
  }
  
  open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let viewModel = tableViewConfigurator?.footerViewModel(for: section) else { return nil }
    return tableView.dequeueReusableView(with: viewModel)
  }
  
  open func refresh() {
    tableViewConfigurator?.didMakeRefresh()
  }
}
//MARK: -
