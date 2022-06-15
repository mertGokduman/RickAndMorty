//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 12.06.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CharacterCell"
    
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 20
            mainView.layer.shadowColor = UIColor.black.cgColor
            mainView.layer.shadowOpacity = 0.25
            mainView.layer.shadowRadius = 5
            mainView.layer.shadowOffset = CGSize(width: 0, height: 10)
            mainView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblCharacterName: UILabel!
    
    var character: SingleCharacter? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configureCell() {
        guard let image = character?.image else { return }
        imgCharacter.loadImageUsingCache(withUrl: image)
        lblCharacterName.text = character?.name
        createBlurView(for: blurView)
    }

}
