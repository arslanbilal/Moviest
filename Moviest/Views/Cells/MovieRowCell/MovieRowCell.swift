//
//  MovieTableViewCell.swift
//  Moviest
//
//  Created by Bilal Arslan on 19.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit
import Kingfisher

class MovieRowCell: BaseTableViewCell, NibLoadable, Instantiatable {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var releaseDateLabel: UILabel!
    @IBOutlet fileprivate weak var overviewLabel: UILabel!
    @IBOutlet fileprivate weak var posterImageView: UIImageView! {
        didSet {
            if let imageView = posterImageView {
                imageView.kf.indicatorType = .activity
            }
        }
    }

    override var viewBindableModel: ViewBidable? {
        didSet {
            guard let bindable = viewBindableModel else {
                return
            }
            titleLabel.text = bindable.getTitle()
            releaseDateLabel.text = bindable.getSubtitle()
            overviewLabel.text = bindable.getSubText()
            if let url = bindable.getImageURL() {
                posterImageView.kf.setImage(with: url)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        styleSetup()
        selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        releaseDateLabel.text = nil
        overviewLabel.text = nil
        posterImageView.image = nil
//        posterImageView.kf.cancelDownloadTask()
    }

}

extension MovieRowCell {

    func styleSetup() {
        posterImageView.layer.borderWidth = 0.3
        posterImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

}
