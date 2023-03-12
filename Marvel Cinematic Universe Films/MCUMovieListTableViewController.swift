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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        let movieData = moviesParser.getMovie(index: indexPath.row)
        cell.textLabel?.text = movieData.title
        cell.detailTextLabel?.text = movieData.saga
        cell.imageView?.image = UIImage(named: movieData.cover)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
