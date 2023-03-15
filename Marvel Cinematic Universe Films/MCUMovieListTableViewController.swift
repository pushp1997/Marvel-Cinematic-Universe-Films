//
//  MCUMovieListTableViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit

class MCUMovieListTableViewController: UITableViewController {
    var moviesParser = MoviesParser()
    
    // Outlets
    @IBOutlet var mcuMovieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Marvel Cinematic Universe Movies List"
        moviesParser.parseMovies()
        
        // Disabling seperator
        mcuMovieListTableView.separatorStyle = .none
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
        
        
        // Styling the Row ui view to look like a card
        cell.rowCardView.layer.cornerRadius = 10
        cell.rowCardView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        cell.rowCardView.layer.shadowOffset = CGSize(width: 1.75, height: 1.75)
        cell.rowCardView.layer.shadowRadius = 1.75
        cell.rowCardView.layer.shadowOpacity = 0.5

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
