//
//  PopularCollectionViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 24/6/24.
//

import UIKit
import Cosmos

class PopularCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var popularMovieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var releaseDate : UILabel!
    @IBOutlet weak var rating : CosmosView!
    @IBOutlet weak var baseView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    
    func configureCell(imageUrl: String? , name: String, releaseYear: String, avgRating: Double?, totalRating: Int?) {
        self.name.text = name
        self.releaseDate.text = AppUtilities.shared.convertMovieReleaseDate(dateString: releaseYear)
        if let imageUrl = imageUrl {
            self.popularMovieImage.loadImage(fromURL: imageUrl)
        }
        if let avgrating = avgRating, let totalRating = totalRating {
            self.rating.rating = avgrating
            self.rating.text = "(\(totalRating))"
        }
    }
}

extension PopularCollectionViewCell {
    func setupTheme() {
        self.baseView.addShadowWithCornerRedious(color: UIColor.gray, opacity: 0.3, sizeX: 0.5, sizeY: 0.5, shadowRadius: 1, cornerRadius: 10)
        self.name.textColor = theme?.colorTheme.colorPrimaryBlack
        self.name.font = theme?.fontTheme.regularMontserrat.font(14)
        self.releaseDate.textColor = theme?.colorTheme.colorPrimaryRed
        self.releaseDate.font = theme?.fontTheme.regularMontserrat.font(12)
        self.rating.contentMode = .center
    }
}
