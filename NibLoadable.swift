//
//  NibLoadable.swift
//  BSTrade
//
//  Created by MSY on 2017/10/9.
//  Copyright © 2017年 Bluestone. All rights reserved.
//

import UIKit

/// 重用标识
protocol Reuseable: class {
    static var reuseIdentifier: String { get }
}

extension Reuseable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension Reuseable where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension Reuseable where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

extension UITableViewCell: Reuseable {}
extension UITableViewHeaderFooterView: Reuseable {}

extension UICollectionReusableView: Reuseable {}

/// Nib加载
protocol NibLoadable {
    static var bst_nibName: String {get}
}

extension NibLoadable where Self: UIView {
    static var bst_nibName: String {
        return "\(self)"
    }

    /// 加载Xib描述的UI控件
    ///
    /// - Parameter nibName: Xib文件名 默认与类名一致
    /// - Returns: 返回加载的UI对象
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed(bst_nibName, owner: nil, options: nil)?.first as! Self
    }

    /// 加载Xib描述的UI控件
    ///
    /// - Parameter nibName: Xib文件名 默认与类名一致
    /// - Returns: 返回加载的UI对象
    static func loadFromNib(index: Int) -> Self? {
        guard let nibArr = Bundle.main.loadNibNamed(bst_nibName, owner: nil, options: nil) else {
            return nil
        }
        return nibArr[index] as? Self
    }
}

extension UITableViewCell : NibLoadable {}
extension UICollectionReusableView: NibLoadable {}
extension UITableViewHeaderFooterView: NibLoadable {}

extension UITableView {

    /// 注册用Xib描述的Cell
    ///
    /// - Parameter _: 该Cell的Class类型
    func registerNib<T: UITableViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.bst_nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// 注册用Xib描述的HeaderFooterView
    ///
    /// - Parameter _: 该HeaderFooterView的Class类型
    func registerNib<T: UITableViewHeaderFooterView> (forHeaderFooter _: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.bst_nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    /// 注册普通Cell
    ///
    /// - Parameter _: 该Cell的Class类型
    func registerClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// 注册普通HeaderFooterView
    ///
    /// - Parameter _: 该HeaderFooterView的Class类型
    func registerClass<T: UITableViewHeaderFooterView>(forHeaderFooter _: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    /// 从缓存池中取出复用的Cell
    ///
    /// - Parameter indexPath: 对应数据源的IndexPath
    /// - Returns: 返回与声明类型一致的Cell exp:let cell: TypeCell = tableView.dequeueReusableCell(for: indexPath）
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("不能从缓存池取出Cell identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    /// 从缓存池中取出复用的headerFooterView
    ///
    /// - Returns: 返回与声明类型一致的HeaderFooterView exp:let cell: TypeCell = tableView.dequeueReusableHeaderFooterView(withIdentifier:）
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("不能从缓存池取出HeaderFooterView identifier: \(T.reuseIdentifier)")
        }
        return headerFooterView
    }
}

extension UICollectionView {

    /// 注册用Xib描述的UICollectionViewCell
    ///
    /// - Parameter _: 该UICollectionViewCell的Class类型
    func registerNib<T: UICollectionViewCell>(_: T.Type)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.bst_nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    /// 注册用Xib描述的UICollectionReusableView
    ///
    /// - Parameter _: 该UICollectionReusableView的Class类型
    /// - Parameter _: 该UICollectionReusableView的kind,用于SupplementaryView
    func registerNib<T: UICollectionReusableView>(_: T.Type, kind: String? = nil)  {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.bst_nibName, bundle: bundle)
        guard let k = kind else {
            fatalError("注册\(T.reuseIdentifier)需要传入有效kind")
        }
        register(nib, forSupplementaryViewOfKind: k, withReuseIdentifier: T.reuseIdentifier)
    }

    /// 注册普通UICollectionViewCell
    ///
    /// - Parameter _: 该UICollectionViewCell的Class类型
    func registerClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)

    }
    /// 注册普通UICollectionReusableView
    ///
    /// - Parameter _: 该UICollectionReusableView的Class类型
    func registerClass<T: UICollectionReusableView>(_: T.Type, kind: String? = nil) {

        guard let k = kind else {
            fatalError("注册\(T.reuseIdentifier)需要传入有效kind")
        }
        register(T.self, forSupplementaryViewOfKind: k, withReuseIdentifier: T.reuseIdentifier)
    }

    /// 从缓存池中取出复用的UICollectionViewCell
    ///
    /// - Parameter indexPath: 对应数据源的IndexPath,用于Cell
    /// - Returns: 返回与声明类型一致的Cell exp:let cell: TypeCell = tableView.dequeueReusableCell(for: indexPath）
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("不能从缓存池取出Cell identifier: \(T.reuseIdentifier)")
        }
        return cell

    }
    /// 从缓存池中取出复用的UICollectionReusableView
    ///
    /// - Parameter indexPath: 对应数据源的IndexPath,用于Cell
    /// - Returns: 返回与声明类型一致的Cell exp:let cell: TypeCell = tableView.dequeueReusableCell(for: indexPath）
    func dequeueReusableCell<T: UICollectionReusableView>(for indexPath: IndexPath, kind: String? = nil) -> T {

        guard let k = kind, let supplementaryView = dequeueReusableSupplementaryView(ofKind: k, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("不能从缓存池取出SupplementaryView identifier: \(T.reuseIdentifier)")
        }
        return supplementaryView
    }
}




