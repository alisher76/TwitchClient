//
//  GamesViewController.swift
//  TwitchClientApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    var refreshController: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Games"
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(GamesViewController.refresh), for: UIControlEvents.valueChanged)
        gamesCollectionView.insertSubview(refreshController, at: 0)
        refresh()
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func refresh() {
        return GameDataService.instance.downloadnTopGames {
            for game in GameDataService.instance.games {
                game.downloadGameImage(completed: {
                    self.gamesCollectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshController.endRefreshing()
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UICOllectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameDataService.instance.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as? GameCollectionViewCell {
            
            let game = GameDataService.instance.games[indexPath.row]
            cell.configureCell(game)
            
            return cell
        } else {
            return GameCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let game = GameDataService.instance.games[indexPath.row]
        performSegue(withIdentifier: "ShowStreamVC", sender: game)
    }
    
    //FlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (gamesCollectionView.bounds.width / 2) - 15
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStreamVC" {
            if let streamVC = segue.destination as? StreamViewController {
                if let game = sender as? Game {
                    streamVC.game = game
                }
            }
        }
    }

}
