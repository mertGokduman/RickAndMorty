//
//  UICollectionViewCell + Extension.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 13.06.2022.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    // Blur View for name label of UICollectionViewCell in MainVC
    func createBlurView(for view: UIView) {
        guard !UIAccessibility.isReduceTransparencyEnabled else { return }
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = UIColor.customBackgroundColor2.withAlphaComponent(0.05)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.masksToBounds = true
        view.insertSubview(blurView, at: 0)

        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: view.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(vibrancyView)

        NSLayoutConstraint.activate([
          vibrancyView
            .heightAnchor
            .constraint(equalTo: blurView.contentView.heightAnchor),
          vibrancyView
            .widthAnchor
            .constraint(equalTo: blurView.contentView.widthAnchor),
          vibrancyView
            .centerXAnchor
            .constraint(equalTo: blurView.contentView.centerXAnchor),
          vibrancyView
            .centerYAnchor
            .constraint(equalTo: blurView.contentView.centerYAnchor)
        ])
    }
}
