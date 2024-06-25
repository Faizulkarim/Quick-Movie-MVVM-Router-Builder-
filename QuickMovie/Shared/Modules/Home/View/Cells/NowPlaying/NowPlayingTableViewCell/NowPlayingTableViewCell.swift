//
//  NowPlayingTableViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit

class NowPlayingTableViewCell: BaseTableViewCell {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var baseView: UIView!
    var cellViewModel : nowPlayingTableCellViewModel?
    func configureCell(cellViewModel : nowPlayingTableCellViewModel?) {
        self.cellViewModel = cellViewModel
        setupUI()
    }
}

extension NowPlayingTableViewCell {
    func setupUI() {
        nowPlayingCollectionView.register(UINib(nibName: "NowPlayingCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "NowPlayingCollectionViewCell")
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.reloadData()
    }
}

extension NowPlayingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.cellViewModel?.data?.count ?? 0
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: NowPlayingCollectionViewCell.self),
                                                         for: indexPath) as? NowPlayingCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let data = cellViewModel?.data?[indexPath.row]
            let imageUrl = "\(cellViewModel?.posterBaseUrl ?? "")\(data?.backdropPath ?? "")"
            cell.configureCell(imageUrl: imageUrl, name: data?.title)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension NowPlayingTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.nowPlayingCollectionView.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }

}

