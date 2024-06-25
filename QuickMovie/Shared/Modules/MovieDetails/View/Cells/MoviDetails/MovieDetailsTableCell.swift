//
//  MovieDetailsTableCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MovieDetailsTableCellDelegate: AnyObject {
    func favoirteButtonTapped(index: Int?)
}

class MovieDetailsTableCell: BaseTableViewCell {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var ratingAvg: UILabel!
    @IBOutlet weak var popularity : UILabel!
    @IBOutlet weak var favoriteButtonView: OTDynamicButton!
    static let height: CGFloat = 50
    @IBOutlet weak var baseView: UIView!
    weak var delegate: MovieDetailsTableCellDelegate?
    var cellViewModel : MovieDetailsTableCellViewModel?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(cellViewModel: MovieDetailsTableCellViewModel?) {
        self.cellViewModel = cellViewModel
        setupUI()
    }
}

//MARK: Cell Configuration
extension MovieDetailsTableCell {
    
    func setupUI(){
        setupFavoriteButton()
        if let coverImageUlr = self.cellViewModel?.coverImage {
            self.coverImage.loadImage(fromURL: coverImageUlr)
        }
        if let posterImageUrl = self.cellViewModel?.posterImage {
            self.posterImage.loadImage(fromURL: posterImageUrl)
        }
        self.name.text = self.cellViewModel?.name
        self.releaseDate.text = self.cellViewModel?.releaseDate
        self.language.text = self.cellViewModel?.language
        self.ratingAvg.text = self.cellViewModel?.avgRating
        self.popularity.text = self.cellViewModel?.popularity
    }
    
    func loadDefultView(favImage: UIImage?) {
        let favoriteButtonViewModel = OTDynamicButtonViewModel(img: favImage,title: "", tintColor: theme?.colorTheme.colorPrimaryRed, titleFont: nil, titleColor: theme?.colorTheme.clearColor, backgroundColor: theme?.colorTheme.clearColor, borderColor: theme?.colorTheme.clearColor, cornerRadius: 15, isHidden: false)
        self.favoriteButtonView.configureView(viewModel: favoriteButtonViewModel) { [weak self] sender in
            self?.delegate?.favoirteButtonTapped(index: self?.indexPath?.row)
            
        }
    }
    
    func setupFavoriteButton() {
        if MovieManager.shared.fetchMovieById(id: cellViewModel?.id ?? 0) != nil {
            loadDefultView(favImage: self.theme?.imageTheme.favoriteFil)
        }else {
            loadDefultView(favImage: self.theme?.imageTheme.favoriteEmpty)
        }
    }
    
    func setupTheme() {
        self.name.textColor = theme?.colorTheme.colorPrimaryWhite
        self.releaseDate.textColor = theme?.colorTheme.colorPrimaryWhite
        self.language.textColor = theme?.colorTheme.colorPrimaryWhite
        self.ratingAvg.textColor = theme?.colorTheme.colorPrimaryWhite
        self.popularity.textColor = theme?.colorTheme.colorPrimaryWhite
        self.name.font = theme?.fontTheme.mediumMontserrat.font(20)
        self.releaseDate.font = theme?.fontTheme.regularMontserrat.font(13)
        self.ratingAvg.font = theme?.fontTheme.regularMontserrat.font(13)
        self.language.font = theme?.fontTheme.regularMontserrat.font(13)
        self.popularity.font = theme?.fontTheme.regularMontserrat.font(13)
    }
    
}

