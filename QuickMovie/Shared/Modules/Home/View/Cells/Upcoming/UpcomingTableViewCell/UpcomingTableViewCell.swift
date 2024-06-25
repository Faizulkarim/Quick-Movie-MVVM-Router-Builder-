//
//  UpcomingTableViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 24/6/24.
//

import UIKit
protocol UpcomingTableViewCellDelegate : AnyObject {
    func tapOnMovieItem(movieItem : Movie?)
}

class UpcomingTableViewCell: BaseTableViewCell {

    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel : UILabel!
    var cellViewModel : UpcomingTableCellViewModel?
    var delegate : UpcomingTableViewCellDelegate?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    func configureCell(cellViewModel : UpcomingTableCellViewModel?) {
        self.cellViewModel = cellViewModel
        self.titleLabel.text = cellViewModel?.title
        setupUI()
    }
}

extension UpcomingTableViewCell {
    func setupUI() {
        upcomingCollectionView.register(UINib(nibName: "UpcomingCollectionCell", bundle: .main), forCellWithReuseIdentifier: "UpcomingCollectionCell")
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.reloadData()
    }
    
    func setupTheme() {
        self.titleLabel.textColor = theme?.colorTheme.colorPrimaryRed
        self.titleLabel.font = theme?.fontTheme.semiboldMontserrat.font(16)
    }
}


extension UpcomingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.cellViewModel?.data?.count ?? 0
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: UpcomingCollectionCell.self),
                                                         for: indexPath) as? UpcomingCollectionCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let data = cellViewModel?.data?[indexPath.row]
            let imageUrl = "\(cellViewModel?.posterBaseUrl ?? "")\(data?.backdropPath ?? "")"
            let name = data?.title ?? ""
            let releaseDate = data?.releaseDate ?? ""
            let avgRating = data?.voteAverage ?? 0.0
            let totalUser = data?.voteCount ?? 0
            cell.configureCell(imageUrl: imageUrl, name: name, releaseYear: releaseDate)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieItem = self.cellViewModel?.data?[indexPath.row] {
            self.delegate?.tapOnMovieItem(movieItem: movieItem)
        }
    }
}

extension UpcomingTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.upcomingCollectionView.frame.width / 1.3) - 5, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }

}


