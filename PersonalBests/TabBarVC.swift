//
//  ViewController.swift
//  PersonalBests
//
//  Created by Eryk Szcześniak on 19/06/2020.
//  Copyright © 2020 Eryk Szcześniak. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }

    func setupTabBar(){
        let homeVC = UINavigationController(rootViewController: HomeVC())
        homeVC.tabBarItem.title = "Home"
        viewControllers = [homeVC]
        
        let runnerVC = UINavigationController(rootViewController:RunnerListVC())
        runnerVC.tabBarItem.title = "Runner"
        viewControllers = [homeVC, runnerVC]
        
    }

}

