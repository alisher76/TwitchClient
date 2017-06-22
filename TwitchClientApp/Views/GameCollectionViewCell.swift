//
//  GameCollectionViewCell.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    func configureCell (_ game: Game) {
        if game.gameImage != nil {
            gameImageView.image = game.gameImage
        }
    }
}
