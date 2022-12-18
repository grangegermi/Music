//
//  TabBarViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//
import UIKit

class TabBarViewController:UITabBarController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let  homeVC  = UINavigationController(rootViewController: HomeViewController())
            let  searchVC = UINavigationController(rootViewController: SearchViewController())
            let  libraryVC = UINavigationController(rootViewController: LibraryViewController())
            
            homeVC.title = "Home"
            searchVC.title = "Search"
            libraryVC.title = "Library"
            view.backgroundColor = .white
            
            homeVC.tabBarItem.image = UIImage(systemName: "house")
            searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
            libraryVC.tabBarItem.image = UIImage(systemName: "building.columns")
            
            self.tabBar.tintColor = .gray
            self.tabBar.backgroundColor = .white
            self.setViewControllers([homeVC, searchVC, libraryVC], animated: false)
        
            ApiCaller.sharedCaller.getUser()
            ApiCaller.sharedCaller.getNewReleases()
            ApiCaller.sharedCaller.getRecommendationsGenres()
        var seeds = Set<String>()
        seeds.count < 5
        ApiCaller.sharedCaller.getRecommendations(genres:seeds)
       
       
    }
    
}
