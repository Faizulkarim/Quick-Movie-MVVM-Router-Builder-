//
//  PopularTableViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 24/6/24.
//

import UIKit
protocol PopularTableViewCellDelegate : AnyObject {
    func tapOnMovieItem(movieItem : Movie?)
}

class PopularTableViewCell: BaseTableViewCell {

    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel : UILabel!
    var cellViewModel : PopularTableCellViewModel?
    var delegate : PopularTableViewCellDelegate?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    func configureCell(cellViewModel : PopularTableCellViewModel?) {
        self.cellViewModel = cellViewModel
        self.titleLabel.text = cellViewModel?.title
        setupUI()
    }
}

extension PopularTableViewCell {
    func setupUI() {
        popularCollectionView.register(UINib(nibName: "PopularCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PopularCollectionViewCell")
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.reloadData()
    }
    
    func setupTheme() {
        self.titleLabel.textColor = theme?.colorTheme.colorPrimaryRed
        self.titleLabel.font = theme?.fontTheme.semiboldMontserrat.font(16)
    }
}


extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.cellViewModel?.data?.count ?? 0
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: PopularCollectionViewCell.self),
                                                         for: indexPath) as? PopularCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let data = cellViewModel?.data?[indexPath.row]
            let imageUrl = "\(cellViewModel?.posterBaseUrl ?? "")\(data?.posterPath ?? "")"
            let name = data?.title ?? ""
            let releaseDate = data?.releaseDate ?? ""
            let avgRating = data?.voteAverage ?? 0.0
            let totalUser = data?.voteCount ?? 0
            cell.configureCell(imageUrl: imageUrl, name: name, releaseYear: releaseDate, avgRating: avgRating, totalRating: totalUser)
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

extension PopularTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.popularCollectionView.frame.width / 2.1) - 5, height: 234)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }

}


