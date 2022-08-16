//
//  ViewController.swift
//  GiorgiPilishvili_Homework23
//
//  Created by GIORGI PILISSHVILI on 16.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables
    
    var arrayOfMovies = [MovieResponseData.Movie]()
    var arrayOfSimilarMovies = [MovieResponseData.Movie]()
    var movieDetails: MovieDetails?

    let semaphore = DispatchSemaphore(value: 1)
    let queue = DispatchQueue(label: "queue",qos: .background)
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queue.async {
            self.semaphore.wait()
            self.fetchTopRatedMovies()
        }
        
        queue.async {
            self.semaphore.wait()
            self.fetchSimilarMovies()
        }
        
        queue.async {
            self.semaphore.wait()
            self.fetchMovieDetails()
        }

    }
    
    // MARK: - Functions

    func fetchTopRatedMovies() {
        
        print("🔴")
        
        let urlString = "https://api.themoviedb.org/3/tv/top_rated?api_key=\(MovieDatabase.APIKey)&language=en-US&page=1"
        
        MovieDatabase.shared.getData(urlString: urlString) { (movieResponseData: MovieResponseData) in
            self.arrayOfMovies = movieResponseData.results
            self.semaphore.signal()
        }
           
        print("🔴🔴")
    }
    
    func fetchSimilarMovies() {
        
        print("🟡")
        
        let randomMovie = arrayOfMovies.randomElement()
        guard let randomMovie = randomMovie else { return }
        
        let urlString = "https://api.themoviedb.org/3/tv/\(randomMovie.id)/similar?api_key=\(MovieDatabase.APIKey)&language=en-US&page=1"
        
        MovieDatabase.shared.getData(urlString: urlString) { (movieResponseData: MovieResponseData) in
            self.arrayOfSimilarMovies = movieResponseData.results
            self.semaphore.signal()
        }
        
        print("🟡🟡")

    }
    
    func fetchMovieDetails() {
        
        print("🔵")
        
        let randomMovie = arrayOfMovies.randomElement()
        guard let randomMovie = randomMovie else { return }

        let urlString = "https://api.themoviedb.org/3/tv/\(randomMovie.id)?api_key=\(MovieDatabase.APIKey)&language=en-US"

        MovieDatabase.shared.getData(urlString: urlString) { (movieDetails: MovieDetails) in
            self.movieDetails = movieDetails
            print("Movie(name: \"\(movieDetails.name)\", numberOfEpisodes: \(movieDetails.numberOfEpisodes))")
            self.semaphore.signal()
        }
        
        print("🔵🔵")

    }
    
}
