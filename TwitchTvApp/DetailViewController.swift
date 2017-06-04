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
    @IBOutlet weak var gameLabel: UILabel!
    
    var gameName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameLabel.text = gameName
    }
}
