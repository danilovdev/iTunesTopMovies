//
//  MovieListViewController.swift
//  iTunesTopMoviesPart1
//
//  Created by Alexey Danilov on 26.05.2018.
//  Copyright © 2018 danilovdev. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private let cellId = "MoviewCell"
    
    private let urlStr = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    
    private var movieList: [Movie] = []
    
    private var selectedMovie: Movie!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        guard let url = URL(string: urlStr) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if let error = error {
                print("Error happened: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200  {
                print("Not successful response with status code: \(response.statusCode)")
                return
            }
            
            guard let data = data else {
                print("Error happened: Data not exists")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let feedJson = json["feed"] as? [String: Any] {
                        let feed = Feed(dict: feedJson)
                        if let movies = feed.movies {
                            self.movieList = movies
                            DispatchQueue.main.async { [unowned self] in
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print("Error happened: \(error.localizedDescription)")
            }
            
        }
        dataTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetails",
            let destination = segue.destination as? MovieDetailsViewController {
            destination.movie = selectedMovie
        }
    }
    
}

// MARK: UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = movieList[indexPath.row].title
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movieList[indexPath.row]
        performSegue(withIdentifier: "ShowMovieDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
