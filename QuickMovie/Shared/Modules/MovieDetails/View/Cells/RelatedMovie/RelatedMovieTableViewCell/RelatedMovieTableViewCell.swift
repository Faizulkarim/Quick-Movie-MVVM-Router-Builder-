//
//  RelatedMovieTableViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit
protocol RelatedMovieTableViewCellDelegate : AnyObject {
    func tapOnMovieItem(movieItem : Movie?)
}
class RelatedMovieTableViewCell: BaseTableViewCell {

    @IBOutlet weak var relatedCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel : UILabel!
    var cellViewModel : RelatedMovieTableCellViewModel?
    var delegate : RelatedMovieTableViewCellDelegate?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupTheme()
    }
    func configureCell(cellViewModel : RelatedMovieTableCellViewModel?) {
        self.cellViewModel = cellViewModel
        self.titleLabel.text = cellViewModel?.title
        setupUI()
    }
}

extension RelatedMovieTableViewCell {
    func setupUI() {
        relatedCollectionView.register(UINib(nibName: "RelatedMovieCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "RelatedMovieCollectionViewCell")
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        relatedCollectionView.reloadData()
      
    }
    
    func setupTheme() {
        self.titleLabel.textColor = theme?.colorTheme.colorPrimaryWhite
        self.titleLabel.font = theme?.fontTheme.semiboldMontserrat.font(16)
    }
}


extension RelatedMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.cellViewModel?.data?.count ?? 0
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: RelatedMovieCollectionViewCell.self),
                                                         for: indexPath) as? RelatedMovieCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let data = cellViewModel?.data?[indexPath.row]
            let posterImageUrl = "\(Constants.posterBaseUrl)\(data?.posterPath ?? "")"
            let name = data?.title ?? ""
            let popularity = String(format: "%.2f", data?.popularity ?? 0.0)
            cell.configureCell(name: name, popularity: "Popularity: \(popularity)", posterimageUrl: posterImageUrl)
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

extension RelatedMovieTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.relatedCollectionView.frame.width / 2.2) - 4, height: self.relatedCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
        
    }

}


