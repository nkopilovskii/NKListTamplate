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
    
    if let isRefreshable = tableViewConfigurator?.isRefreshable, isRefreshable {
      contentTableView?.addRefresh(target: self, action: #selector(refresh), text: tableViewConfigurator?.refreshTitle)
    } else {
      contentTableView?.deleteRefresh()
    }
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
  
  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableViewConfigurator?.didSelectItem(at: indexPath)
  }
  
  @objc open func refresh() {
    tableViewConfigurator?.didMakeRefresh()
  }
}
//MARK: -


//MARK: - UITableView Refresh Control
extension UITableView {
  
  func addRefresh(target: Any?, action: Selector, text: String? = nil) {
    guard refreshControl == nil else { return }
    let control = UIRefreshControl()
    control.addTarget(target, action: action, for: .valueChanged)
    control.layer.zPosition = -1
    
    if let text = text {
      control.attributedTitle = NSAttributedString(string: text)
    }
    
    refreshControl = control
  }
  
  func deleteRefresh() {
    refreshControl?.removeFromSuperview()
    refreshControl = nil
  }
  
}
//MARK: -
