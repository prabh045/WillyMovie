//
//  Connection.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 07/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation
import Network

class Connection {

    static let monitor = NWPathMonitor(requiredInterfaceType: .wifi)
    
    static func startMonitoringConnection(handler: MovieViewModel) {
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connection Avaialble")
                handler.retrieveMovies(movie: "Guardians")
            } else if path.status == .requiresConnection{
                print("Requires connection")
                handler.loadMovies()
            } else {
                print("No connection")
                handler.loadMovies()
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
}
