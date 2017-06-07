//
//  ViewController.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let refreshControl = UIRefreshControl()
    var gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPullToRefresh()
        loadGames()
    }

    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(cellType: GameCell.self)
    }
    
    func setupPullToRefresh() {
        if #available(iOS 10.0, *) {
            self.collectionView.refreshControl = refreshControl
        } else {
            self.collectionView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(loadGames), for: .valueChanged)
    }
    
    func loadGames() {
        gameManager.loadGames { success in
            if !success {
                self.presentAlert(withTitle: "Oops!",
                                  andMessage: "Could not fetch data. Please try again later or check your connection.")
            }
            
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vController.game = gameManager.gameAt(index: indexPath.row)
        navigationController?.pushViewController(vController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameManager.gamesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameCell.self)
        let game = gameManager.gameAt(index: indexPath.row)
        cell.setup(game: game)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vertical = self.traitCollection.verticalSizeClass
        let horizontal = self.traitCollection.horizontalSizeClass
        var width = collectionView.bounds.size.width
        
        if vertical == .regular && horizontal == .regular {
            width = width/6
        } else if (vertical == .compact) {
            width = width/4
        } else {
            width = width/2
        }
        
        return CGSize(width: width, height: width*1.3)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

