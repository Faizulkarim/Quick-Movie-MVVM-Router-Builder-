//
//  BaseTableViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation

import UIKit

// MARK: BaseCellPosition
enum BaseCellPosition {
    case first
    case last
    case unknown
}

// MARK: BaseTableViewCellProtocol
protocol BaseTableViewCellProtocol {
    func reloadCell(_ indexPath: IndexPath)
}

extension BaseTableViewCellProtocol {
    func reloadCell(_ indexPath: IndexPath) {}
}

// MARK: BaseTableViewCell
class BaseTableViewCell: UITableViewCell {

    var analyticsManager: AnalyticsManager?
    var theme: Theme?
    
    var baseDelegate: BaseTableViewCellProtocol?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
