//
//  OverviewTableViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit

class OverviewTableViewCell: BaseTableViewCell {

    @IBOutlet weak var overview: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTheme()
    }
    func configureCell(overViewText: String?) {
        self.overview.text = overViewText
    }
}

extension OverviewTableViewCell{
    func setupTheme() {
        self.overview.textColor = theme?.colorTheme.colorPrimaryWhite
        self.overview.font = theme?.fontTheme.regularMontserrat.font(13)
    }
}
