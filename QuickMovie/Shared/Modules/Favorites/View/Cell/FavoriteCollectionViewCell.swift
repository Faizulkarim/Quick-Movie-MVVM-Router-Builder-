//
//  FavoriteCollectionViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit
protocol FavoriteCollectionViewCellDelegate: AnyObject {
    func favoriteButtonTapped(index: Int?)
}

class FavoriteCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var favoirteImage: UIImageView!
    var delegate: FavoriteCollectionViewCellDelegate?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    func configureCell(name: String?, releaseYear: String?, posterImage: String?){
        self.name.text = name
        self.releaseYear.text = AppUtilities.shared.convertMovieReleaseDate(dateString: releaseYear ?? "")   
        if let posterImage = posterImage {
            self.posterImage.loadImage(fromURL: posterImage)
        }
        setupAction()
    }

}

extension FavoriteCollectionViewCell {
    func setupAction() {
        favoirteImage.handleTapToAction {
            self.delegate?.favoriteButtonTapped(index: self.indexPath?.row)
        }
    }
    func setupTheme() {
        self.favoirteImage.image = theme?.imageTheme.favoriteFil
    }
}
