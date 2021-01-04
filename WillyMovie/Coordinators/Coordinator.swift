//
//  Coordinator.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 31/12/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
