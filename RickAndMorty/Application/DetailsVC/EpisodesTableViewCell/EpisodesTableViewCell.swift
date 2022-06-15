//
//  EpisodesTableViewCell.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 14.06.2022.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 40
    static let identifier: String = "EpisodeCell"

    @IBOutlet weak var lblEpisodeName: UILabel! {
        didSet {
            lblEpisodeName.font = UIFont(name: "Nunito-ExtraBold", size: UIScreen.main.bounds.height < 850 ? 14 : 16)
        }
    }
    @IBOutlet weak var lblEpisodeNumber: UILabel! {
        didSet {
            lblEpisodeNumber.font = UIFont(name: "Nunito-Bold", size: UIScreen.main.bounds.height < 850 ? 14 : 16)
        }
    }
    
    var episode: EpisodeModel? {
        didSet {
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setData() {
        lblEpisodeName.text = episode?.name
        lblEpisodeNumber.text = episode?.episode
    }
    
}
