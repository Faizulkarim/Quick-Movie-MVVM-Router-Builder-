//
//  TrendingTableViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit
protocol TrendingTableViewCellDelegate : AnyObject {
    func tapOnMovieItem(movieItem : Movie?)
}

class TrendingTableViewCell: BaseTableViewCell {

    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel : UILabel!
    var cellViewModel : trendingTableCellViewModel?
    var delegate : TrendingTableViewCellDelegate?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    func configureCell(cellViewModel : trendingTableCellViewModel?) {
        self.cellViewModel = cellViewModel
        self.titleLabel.text = cellViewModel?.title
        setupUI()
    }
}

extension TrendingTableViewCell {
    func setupUI() {
        trendingCollectionView.register(UINib(nibName: "TrendingCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.reloadData()
    }
    
    func setupTheme() {
        self.titleLabel.textColor = theme?.colorTheme.colorPrimaryRed
        self.titleLabel.font = theme?.fontTheme.semiboldMontserrat.font(16)
    }
}


extension TrendingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.cellViewModel?.data?.count ?? 0
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: TrendingCollectionViewCell.self),
                                                         for: indexPath) as? TrendingCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let data = cellViewModel?.data?[indexPath.row]
            let imageUrl = "\(cellViewModel?.posterBaseUrl ?? "")\(data?.posterPath ?? "")"
            let name = data?.title ?? ""
            let releaseDate = data?.releaseDate ?? ""
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

extension TrendingTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.trendingCollectionView.frame.width / 3.1) - 2, height: 210)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
        
    }

}


