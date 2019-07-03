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
  
  func beginRefresh()
  func endRefresh()
  
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
  
  }
  
  func beginRefresh() {
    let offsetPoint = CGPoint.init(x: 0, y: -(contentTableView?.refreshControl?.frame.size.height ?? 0))
    contentTableView?.setContentOffset(offsetPoint, animated: true)
    contentTableView?.refreshControl?.beginRefreshing()
  }
  
  func endRefresh() {
    updateTableView { self.contentTableView?.refreshControl?.endRefreshing() }
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
  
}
//MARK: -




