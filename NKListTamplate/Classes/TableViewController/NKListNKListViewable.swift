//
//  NKListViewable.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 6/27/19.
//

import UIKit

//MARK: - NKListViewable protocol
public protocol NKListViewable: class {
  
  var tableViewConfigurator: NKListConfigurator? { get }
  var tableView: UITableView? { get }
  
  func configurateViewModels()
  
  func reloadTableView()
  func reloadSections(_ sections: [Int], with animation: UITableView.RowAnimation)
  func insertSections(_ sections: [Int], with animation: UITableView.RowAnimation)
  func deleteSections(_ sections: [Int], with animation: UITableView.RowAnimation)
  
  func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
  func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
  func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
}
//MARK: -

//MARK: - NKListViewable base implementation
public extension NKListViewable {
  
  func configurateViewModels() {
    guard let tableViewConfigurator = tableViewConfigurator else { return }
    tableView?.registerCell(nibModels: tableViewConfigurator.cellViewModelTypes)
    tableView?.registerView(nibModels: tableViewConfigurator.headerViewModelTypes ?? [])
    tableView?.registerView(nibModels: tableViewConfigurator.footerViewModelTypes ?? [])
    
    if tableViewConfigurator.isRefreshable {
      tableView?.addRefresh(target: self, action: Selector(("refresh")), text: tableViewConfigurator.refreshTitle)
    }
  
  }
  
  func reloadTableView() {
    updateTableView { self.tableView?.reloadData() }
  }
  
  func reloadSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.tableView?.reloadSections(IndexSet(sections), with: animation) }
  }
  
  func insertSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.tableView?.insertSections(IndexSet(sections), with: animation) }
  }
  
  func deleteSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.tableView?.deleteSections(IndexSet(sections), with: animation) }
  }
  
  func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.tableView?.reloadRows(at: indexPaths, with: animation) }
  }
  
  func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.tableView?.insertRows(at: indexPaths, with: animation) }
  }
  
  func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.tableView?.deleteRows(at: indexPaths, with: animation) }
  }
  
  
  fileprivate typealias UpdateAction = () -> ()
  
  fileprivate func updateTableView(_ action: UpdateAction? = nil) {
    DispatchQueue.main.async {
      self.tableView?.beginUpdates()
      action?()
      self.tableView?.endUpdates()
    }
  }
  
  fileprivate func refresh() {
    tableViewConfigurator?.didMakeRefresh()
  }
  
}
//MARK: -

//MARK: - UITableViewDataSource & UITableViewDelegate base implementation
extension UIViewController: UITableViewDataSource, UITableViewDelegate {
  fileprivate var tableViewConfigurator: NKListConfigurator? {
    return nil
  }
  
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewConfigurator?.numberOfSections ?? 0
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewConfigurator?.numberOfRows(in: section) ?? 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = tableViewConfigurator?.cellViewModel(for: indexPath) else { return UITableViewCell() }
    return tableView.dequeueReusableCell(with: viewModel, for: indexPath)
  }
  
  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let viewModel = tableViewConfigurator?.headerViewModel(for: section) else { return nil }
    return tableView.dequeueReusableView(with: viewModel)
  }
  
  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let viewModel = tableViewConfigurator?.footerViewModel(for: section) else { return nil }
    return tableView.dequeueReusableView(with: viewModel)
  }
  
}
//MARK: -


//MARK: - UITableView Refresh Control
fileprivate extension UITableView {
  
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
