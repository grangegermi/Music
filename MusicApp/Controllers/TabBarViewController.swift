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
        
        homeVC.title = "Главная"
       
        searchVC.title = "Поиск"
        libraryVC.title = "Библиотека"
        view.backgroundColor = .white
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.navigationBar.barStyle = .black
        
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchVC.navigationBar.barStyle = .black
        
        libraryVC.tabBarItem.image = UIImage(systemName: "building.columns")
        libraryVC.navigationBar.barStyle = .black
        
        self.tabBar.tintColor = .white
        self.tabBar.barStyle = .black
        self.setViewControllers([homeVC, searchVC, libraryVC], animated: false)  
    }
}
     
        

