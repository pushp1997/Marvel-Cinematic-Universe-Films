//
//  MCUMovieListTableViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit

class MCUMovieListTableViewController: UITableViewController {
    var moviesParser = MoviesParser()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Marvel Cinematic Universe Movies List"
        moviesParser.parseMovies()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moviesParser.getCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // Configure the cell...
        let movieData = moviesParser.getMovie(index: indexPath.row)
        cell.coverImageView.image = UIImage(named: movieData.cover)
        cell.title.text = movieData.title

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovie"{
            let destinationController = segue.destination as! MovieViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            destinationController.movieData = moviesParser.getMovie(index: indexPath!.row)
        }
    }

}
