//
//  LoadingView.swift
//  Moviest
//
//  Created by Bilal Arslan on 20.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class LoadingView: UIView, NibLoadable, Instantiatable {

    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var loadingLabel: UILabel!

    override func awakeFromNib() {
        loadingView.layer.cornerRadius = 5
        loadingView.backgroundColor = .clear
        loadingLabel.textColor = .black
        activityIndicator.color = .black

        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.insertSubview(blurView, at: 0)

        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: loadingView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: loadingView.widthAnchor),
            ])
    }

}
