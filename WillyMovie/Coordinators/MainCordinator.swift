//
//  MainCordinator.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 31/12/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class MainCordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(identifier: "viewController") as? ViewController
        vc?.coordinator = self
        navigationController.pushViewController(vc!, animated: true)
    }
    
    func showMovieDetails(movieId: String) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(identifier: "movieDetailVc") as? MovieDetailController
        vc?.movieId = movieId
        navigationController.pushViewController(vc!, animated: true)
    }
}
