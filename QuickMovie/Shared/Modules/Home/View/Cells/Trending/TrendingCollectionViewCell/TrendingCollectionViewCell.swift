//
//  TrendingCollectionViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit

class TrendingCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var trendingMovieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var releaseDate : UILabel!
    @IBOutlet weak var baseView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    
    func configureCell(imageUrl: String? , name: String, releaseYear: String) {
        if let imageUrl = imageUrl {
            self.trendingMovieImage.loadImage(fromURL: imageUrl)
        }
        self.name.text = name
        self.releaseDate.text = AppUtilities.shared.convertMovieReleaseDate(dateString: releaseYear,dateFormate: "MMMM, yyyy")
        
    }
}

extension TrendingCollectionViewCell {
    func setupTheme() {
        self.baseView.addShadowWithCornerRedious(color: UIColor.gray, opacity: 0.3, sizeX: 0.5, sizeY: 0.5, shadowRadius: 1, cornerRadius: 10)
        self.name.textColor = theme?.colorTheme.colorPrimaryBlack
        self.name.font = theme?.fontTheme.regularMontserrat.font(12)
        self.releaseDate.textColor = theme?.colorTheme.colorPrimaryRed
        self.releaseDate.font = theme?.fontTheme.regularMontserrat.font(10)
    }
}
