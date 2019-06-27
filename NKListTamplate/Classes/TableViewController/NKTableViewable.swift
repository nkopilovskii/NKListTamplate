//
//  NKTableViewable.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 6/27/19.
//

import UIKit

//MARK: - NKTableViewContainer
public typealias NKTableViewContainer = (UIViewController & UITableViewDataSource & UITableViewDelegate)
//MARK: -

//MARK: - NKTableViewable protocol
public protocol NKTableViewable where Self: NKTableViewContainer {
  
  var tableViewConfigurator: NKTableViewConfigurator? { get }
  var tableView: UITableView { get }
  
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

//MARK: - NKTableViewable base implementation
public extension NKTableViewable {
  
  func configurateViewModels() {
    guard let tableViewConfigurator = tableViewConfigurator else { return }
    tableView.delegate = self
    tableView.dataSource = self
    tableView.registerCell(nibModels: tableViewConfigurator.cellViewModelTypes)
    tableView.registerView(nibModels: tableViewConfigurator.headerViewModelTypes ?? [])
    tableView.registerView(nibModels: tableViewConfigurator.footerViewModelTypes ?? [])
    
    if tableViewConfigurator.isRefreshable {
      tableView.addRefresh(target: self, action: Selector(("refresh")), text: tableViewConfigurator.refreshTitle)
    }
  
  }
  
  func reloadTableView() {
    DispatchQueue.main.async {
      self.tableView.beginUpdates()
      self.tableView.reloadData()
      self.tableView.endUpdates()
    }
  }
  
  func reloadSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    DispatchQueue.main.async {
      self.tableView.beginUpdates()
      self.tableView.reloadSections(IndexSet(sections), with: animation)
      self.tableView.endUpdates()
    }
  }
  
  func insertSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    DispatchQueue.main.async {
      self.tableView.beginUpdates()
      self.tableView.insertSections(IndexSet(sections), with: animation)
      self.tableView.endUpdates()
    }
  }
  
  func deleteSections(_ sections: [Int], with animation: UITableView.RowAnimation = .automatic) {
    DispatchQueue.main.async {
      self.tableView.beginUpdates()
      self.tableView.deleteSections(IndexSet(sections), with: animation)
      self.tableView.endUpdates()
    }
  }
  
  func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    DispatchQueue.main.async {
      self.tableView.beginUpdates()
      self.tableView.reloadRows(at: indexPaths, with: animation)
      self.tableView.endUpdates()
    }
  }
  
  func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    DispatchQueue.main.async {
      self.tableView.beginUpdates()
      self.tableView.insertRows(at: indexPaths, with: animation)
      self.tableView.endUpdates()
    }
  }
  
  func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation = .automatic) {
    DispatchQueue.main.async {
      self.tableView.beginUpdates()
      self.tableView.deleteRows(at: indexPaths, with: animation)
      self.tableView.endUpdates()
    }
  }
  
}
//MARK: -

//MARK: - UITableViewDataSource base implementation
public extension NKTableViewable {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewConfigurator?.numberOfSections ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewConfigurator?.numberOfRows(in: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = tableViewConfigurator?.cellViewModel(for: indexPath) else {
      return UITableViewCell()
    }
    return tableView.dequeueReusableCell(with: viewModel, for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let viewModel = tableViewConfigurator?.headerViewModel(for: section) else {
      return nil
    }
    return tableView.dequeueReusableView(with: viewModel)
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let viewModel = tableViewConfigurator?.footerViewModel(for: section) else {
      return nil
    }
    return tableView.dequeueReusableView(with: viewModel)
  }
  
}
//MARK: -

fileprivate extension NKTableViewable {
  
  func refresh() {
    tableViewConfigurator?.didRefresh()
  }

}

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
