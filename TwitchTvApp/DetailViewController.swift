//
//  DetailViewController.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var channelsLabel: UILabel!
    @IBOutlet weak var viewersLabel: UILabel!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    func setupGame() {
        self.title = game?.name
        self.image.kf.setImage(with: game?.image)
        self.channelsLabel.text = "\(game?.channels ?? 0)"
        self.viewersLabel.text = "\(game?.viewers ?? 0)"
    }
}
