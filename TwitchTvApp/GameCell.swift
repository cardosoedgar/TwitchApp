//
//  GameCell.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import UIKit
import Kingfisher

class GameCell: UICollectionViewCell, ReusableCell, LoadNib {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func setup(game: Game) {
        self.image.kf.setImage(with: game.image)
        self.label.text = game.name
    }
}
