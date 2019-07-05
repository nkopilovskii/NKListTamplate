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

//  NKListViewController.swift
//  NKListTamplate
//
//  Created by Nick Kopilovskii on 7/3/19.
//

import UIKit
import NKAnyViewModel

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
