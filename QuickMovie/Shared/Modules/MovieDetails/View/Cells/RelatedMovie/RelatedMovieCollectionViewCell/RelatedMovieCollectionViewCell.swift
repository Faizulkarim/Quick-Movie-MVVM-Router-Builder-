//
//  RelatedMovieCollectionViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit

class RelatedMovieCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    func configureCell(name: String?, popularity: String?, posterimageUrl: String?) {
        self.name.text = name
        self.popularity.text = popularity
        if let posterimageUrl = posterimageUrl {
            self.posterImage.loadImage(fromURL: posterimageUrl)
        }
    }
}

extension RelatedMovieCollectionViewCell {
    func setupTheme() {
        self.baseView.addShadowWithCornerRedious(color: UIColor.gray, opacity: 0.3, sizeX: 0.5, sizeY: 0.5, shadowRadius: 1, cornerRadius: 10)
        self.popularity.textColor = theme?.colorTheme.colorPrimaryWhite
        self.name.textColor = theme?.colorTheme.colorPrimaryWhite
        self.popularity.font = theme?.fontTheme.regularMontserrat.font(10)
        self.name.font = theme?.fontTheme.regularMontserrat.font(13)
    }
}
