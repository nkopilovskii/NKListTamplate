//
//
//Copyright (c) 2019 Nick Kopilovskii <nkopilovskii@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

//  NKListViewable.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 6/27/19.
//

import UIKit
import NKAnyViewModel

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




