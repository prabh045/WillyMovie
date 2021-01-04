//
//  Indicator.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 12/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class Indicator: UIView {
    
   var isRunning: Bool = false {
        didSet {
            toggleIndicator(isRunning)
        }
    }
    
    var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.darkGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 0.9)
        self.layer.cornerRadius = 12
        addSubview(indicator)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func toggleIndicator(_ value: Bool) {
        switch value {
        case true:
            indicator.startAnimating()
            self.isHidden = false
        case false:
            indicator.stopAnimating()
            self.isHidden = true
        }
    }
    

}
