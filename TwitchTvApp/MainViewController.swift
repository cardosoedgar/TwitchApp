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
    
    let twitchRequest = TwitchRequest()
    var response = Response(shouldFetchGames: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadGames()
    }

    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(cellType: GameCell.self)
        
        setupPullToRefresh()
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
        twitchRequest.getGames { response in
            guard let response = response else {
                if self.response.games.count == 0 {
                    self.response = Response(shouldFetchGames: true)
                    self.collectionView.reloadData()
                }
                self.refreshControl.endRefreshing()
                self.presentAlert(withTitle: "Oops!", andMessage: "Could not fetch data. Please try again later.")
                return
            }
        
            self.response = response
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vController.game = response.games[indexPath.row]
        navigationController?.pushViewController(vController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameCell.self)
        cell.setup(game: response.games[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / 2
        return CGSize(width: width, height: width*1.3)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

