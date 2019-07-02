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
  var contentTableView: UITableView? { get }
  
  func configurateTableView()
  
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
  
  func configurateTableView() {
    guard let tableViewConfigurator = tableViewConfigurator else { return }
    contentTableView?.registerCell(nibModels: tableViewConfigurator.cellViewModelTypes)
    contentTableView?.registerView(nibModels: tableViewConfigurator.headerViewModelTypes ?? [])
    contentTableView?.registerView(nibModels: tableViewConfigurator.footerViewModelTypes ?? [])
    
    if tableViewConfigurator.isRefreshable {
      contentTableView?.addRefresh(target: self, action: Selector(("refresh")), text: tableViewConfigurator.refreshTitle)
    }
  
  }
  
  func reloadTableView() {
    updateTableView { self.contentTableView?.reloadData() }
  }
  
  func reloadSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.contentTableView?.reloadSections(IndexSet(sections), with: animation) }
  }
  
  func insertSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.contentTableView?.insertSections(IndexSet(sections), with: animation) }
  }
  
  func deleteSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.contentTableView?.deleteSections(IndexSet(sections), with: animation) }
  }
  
  func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.contentTableView?.reloadRows(at: indexPaths, with: animation) }
  }
  
  func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.contentTableView?.insertRows(at: indexPaths, with: animation) }
  }
  
  func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    updateTableView { self.contentTableView?.deleteRows(at: indexPaths, with: animation) }
  }
  
  
  fileprivate typealias UpdateAction = () -> ()
  
  fileprivate func updateTableView(_ action: UpdateAction? = nil) {
    DispatchQueue.main.async {
      self.contentTableView?.beginUpdates()
      action?()
      self.contentTableView?.endUpdates()
    }
  }
  
  fileprivate func refresh() {
    tableViewConfigurator?.didMakeRefresh()
  }
  
}
//MARK: -

//MARK: - UITableViewDataSource & UITableViewDelegate base implementation
open class NKViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NKListViewable {
  
  open var tableViewConfigurator: NKListConfigurator? { return nil }
  open var contentTableView: UITableView? { return nil }
  
  
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
