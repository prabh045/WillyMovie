//
//  ViewController.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 06/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController{
    
    //MARK: Properties
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchMovieTextField: UITextField!
    var movieViewModel = MovieViewModel(movieApi: MovieService())
    var presentAnimator = Animator()
    var dismissAnimator = DismissAnimator()
    var selectedRowFrame = CGRect.zero
    var coordinator: MainCordinator?
    lazy var activityIndicator: Indicator = {
        var indicator = Indicator(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.navigationController?.delegate = self
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.separatorStyle = .none
        
        searchMovieTextField.delegate = self
        searchMovieTextField.enablesReturnKeyAutomatically = true
        
        moviesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        
        Connection.startMonitoringConnection(handler: movieViewModel)
        
        movieViewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
        view.addSubview(activityIndicator)
        movieViewModel.shouldShowIndicator.bind { (value) in
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.isRunning = value
            }
            
        }
        setupConstraints()
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        //constraints for activity indicator
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 100),
            activityIndicator.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
}

//MARK: TableView Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell else {
            fatalError("Could not initialise movie cell")
        }
        movieCell.movieTitleLabel.text = movieViewModel.getMovieTitle(index: indexPath.row)
        movieCell.movieYear.text = movieViewModel.getMovieYear(index: indexPath.row)
        movieCell.moviePoster.kf.setImage(with: movieViewModel.getMoviePosterUrl(index: indexPath.row))
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frame = tableView.convert(tableView.rectForRow(at: indexPath), to: self.view)
        selectedRowFrame = frame
        coordinator?.showMovieDetails(movieId: movieViewModel.getMovieId(index: indexPath.row))
    }
    
}

//MARK: TextFieldDelegate Extension
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        movieViewModel.retrieveMovies(movie: textField.text ?? "")
    }
}

//MARK: TransitionDelegate
extension ViewController:UINavigationControllerDelegate  {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            presentAnimator.originFrame = selectedRowFrame
            print("Frame is",selectedRowFrame)
            return presentAnimator
        case .pop:
            dismissAnimator.originFrame = selectedRowFrame
            return dismissAnimator
        default:
            return nil
        }
        
    }
    
}



