//
//  NowPlayingCollectionViewCell.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import UIKit

class NowPlayingCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    func configureCell(imageUrl: String?, name: String?) {
        if let imageUrl = imageUrl {
            self.coverImage.loadImage(fromURL: imageUrl)
        }
        self.name.text = name
    }

}
