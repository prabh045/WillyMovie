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
    var movieViewmodel = MovieViewModel()
    var presentAnimator = Animator()
    var dismissAnimator = DismissAnimator()
    var selectedRowFrame = CGRect.zero
    
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
        // searchMovieTextField.becomeFirstResponder()
        searchMovieTextField.enablesReturnKeyAutomatically = true
        
        moviesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        
        Connection.startMonitoringConnection(handler: movieViewmodel)
        
        movieViewmodel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
        
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVc = segue.destination as? MovieDetailController {
            if let index = sender as? Int {
                destinationVc.movieId = movieViewmodel.getMovieId(index: index)
            }
        }
    }
    
    
}

//MARK: TableView Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewmodel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieCell else {
            fatalError("Could not initialise movie cell")
        }
        movieCell.movieTitleLabel.text = movieViewmodel.getMovieTitle(index: indexPath.row)
        movieCell.movieYear.text = movieViewmodel.getMovieYear(index: indexPath.row)
        movieCell.moviePoster.kf.setImage(with: movieViewmodel.getMoviePosterUrl(index: indexPath.row))
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frame = tableView.convert(tableView.rectForRow(at: indexPath), to: self.view)
        selectedRowFrame = frame
        performSegue(withIdentifier: "showMovieDetail", sender: indexPath.row)
    }
    
}

//MARK: TextFieldDelegate Extension
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        movieViewmodel.retrieveMovies(movie: textField.text ?? "")
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



