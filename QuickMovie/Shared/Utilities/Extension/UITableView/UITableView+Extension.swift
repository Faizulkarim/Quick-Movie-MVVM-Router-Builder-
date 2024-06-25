//
//  UITableView+Extension.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit

protocol Reusable {}
extension Reusable where Self: UITableViewCell {
    static var nameId: String {
        return String(describing: self)
    }
}

protocol ReusableView {}
extension ReusableView where Self: UIView {
    static var nameId: String {
        return String(describing: self)
    }
}

protocol ReusableHeaderFooterView {}
extension Reusable where Self: UITableViewHeaderFooterView {
    static var nameId: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UIView: ReusableView {}
extension UITableViewHeaderFooterView: ReusableHeaderFooterView {}

extension UITableView {

    func registerCellClass<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.nameId)
    }

    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(UINib(nibName: cellClass.nameId, bundle: nil), forCellReuseIdentifier: cellClass.nameId)
    }
    
    func registerHeaderFooter<HeaderFooterView: UITableViewHeaderFooterView>(_ cellClass: HeaderFooterView.Type) {
        register(UINib(nibName: cellClass.nameId, bundle: nil), forHeaderFooterViewReuseIdentifier: cellClass.nameId)
    }
    
    func registerHeaderFooterClass<HeaderFooterView: UITableViewHeaderFooterView>(_ cellClass: HeaderFooterView.Type) {
        register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.nameId)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath, cellClass: Cell.Type) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellClass.nameId,
                                                  for: indexPath) as? Cell else {
            fatalError("Fatal error for cell at \(indexPath)")
            
        }
        return cell
    }
    
    func dequeueReusableheaderFooterView<Cell: UITableViewHeaderFooterView>(cellClass: Cell.Type) -> Cell {
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: cellClass.nameId) as? Cell else {
            fatalError("Fatal error for header footer view")
            
        }
        return cell
    }
}

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}

extension NSLayoutConstraint {
    
    /// Get description of broken constaint
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
