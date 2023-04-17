//
//  MCUMovieListTableViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit
import CoreData


extension UIView {
    func nearestAncestor<T>(ofType type: T.Type) -> T? {
        if let me = self as? T { return me }
        return superview?.nearestAncestor(ofType: type)
    }
}


class MCUMovieListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Outlets

    @IBOutlet var mcuMovieListTableView: UITableView!

    // MARK: - Actions

    @IBAction func addMovieButtonPressed(_ sender: Any) {
    }

    @IBAction func ResetButtonPressed(_ sender: Any) {
        // Create Alert to confirm action
        let alert = UIAlertController(title: "Reset Data", message: "Are you sure you want to restore the app? This effectively truncates all the changes made yet and repopulates data from the XML to Core Data.", preferredStyle: .alert)
        
        // Configuring Cancel button
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Configuring Sure button
        // The sure button populates the Core Data by parsing the XML and deletes all existing progress
        let sureButton = UIAlertAction(title: "Sure", style: .default) { (action) in
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: self.fetchRequest())

            do {
                try self.context.execute(deleteRequest)
                try self.context.save()
            } catch {
                print("Couldnt delete existing data from the database.")
            }
            
            let moviesParser = MoviesParser()
            moviesParser.parseMovies()
            
            // Fetching new Data after rest
            do {
                try self.frc.performFetch()
            }catch {
                print("Cannot fetch the data from DB");
            }
            self.mcuMovieListTableView.reloadData()
        }
        
        alert.addAction(cancelButton)
        alert.addAction(sureButton)
        self.present(alert, animated: true)
    }
    
    // MARK: - Core data objects and methods

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    var managedMCUMoviesObject: MCUMovies!;
    var managedFavouritesObject: Favourites!;
    var frc: NSFetchedResultsController<NSFetchRequestResult>!;
    var indexpath1 : IndexPath!
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MCUMovies");
        // Sorting chronologically
        let sorted = NSSortDescriptor(key: "chronology", ascending: true);
        request.sortDescriptors = [sorted];
        return request;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MCU Movies List"

        // Disabling seperator
        mcuMovieListTableView.separatorStyle = .none

        // Making frc and fetch
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil);
        do {
            try frc.performFetch()
        }catch {
            print("Cannot fetch the data from DB");
        }

        frc.delegate = self;
    }

    // MARK: - Update / Favourite / Delete Handlers

    @IBAction func favouriteButtonInsideCell(_ sender: UIButton) {
        // Getting the index path of the cell that the favourite button resides in
        guard
            let button = sender as? UIView,
            let cell = button.nearestAncestor(ofType: UITableViewCell.self),
            let tableView = cell.nearestAncestor(ofType: UITableView.self),
            let indexPath = tableView.indexPath(for: cell)
            else { return }
        managedMCUMoviesObject = frc.object(at: indexPath) as? MCUMovies;
        if managedMCUMoviesObject.favourite!.added {
            managedMCUMoviesObject.favourite!.added = false
            do {
                try self.context.save()
            } catch {
                print("Could not Unlike the movie.")
            }
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            managedMCUMoviesObject.favourite!.added = true
            do {
                try self.context.save()
            } catch {
                print("Could not like the movie.")
            }
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }

    @IBAction func editButtonInsideCell(_ sender: UIButton) {
        // Getting the index path of the cell that the edit button resides in
        guard
            let button = sender as? UIView,
            let cell = button.nearestAncestor(ofType: UITableViewCell.self),
            let tableView = cell.nearestAncestor(ofType: UITableView.self),
            let indexPath = tableView.indexPath(for: cell)
            else { return }
        print("Button pressed at: ", indexPath)
    }

    private func handleMoveToTrash(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) {
        managedMCUMoviesObject = frc.object(at: indexPath) as? MCUMovies;
        self.context.delete(managedMCUMoviesObject)
        do {
            try self.context.save()
        } catch {
            print("Could not delete the movie.")
        }
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Trash action
        let trash = UIContextualAction(style: .destructive,title: "Trash") { [weak self] (action, view, completionHandler) in
                                        self?.handleMoveToTrash(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
                                        completionHandler(true)
        }
        trash.image = UIImage(systemName: "trash")
        trash.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [trash])
     }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return frc.sections![section].numberOfObjects;
        return frc.sections![0].numberOfObjects;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        // Extract from frc the object at indexpath
        managedMCUMoviesObject = frc.object(at: indexPath) as? MCUMovies;

        // Configure the cell...
        cell.coverImageView.image = UIImage(data: managedMCUMoviesObject.cover!)
        cell.title.text = managedMCUMoviesObject.title
        if managedMCUMoviesObject.favourite?.added == true{
            cell.favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            cell.favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        
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

            // Extract from frc the object at indexpath
            managedMCUMoviesObject = frc.object(at: indexPath!) as? MCUMovies;

            destinationController.movieData = managedMCUMoviesObject
        }
        if segue.identifier == "toEdit"{
            let destinationController = segue.destination as! UpdateMovieViewControllerViewController
            guard
                let button = sender as? UIView,
                let cell = button.nearestAncestor(ofType: UITableViewCell.self),
                let tableView = cell.nearestAncestor(ofType: UITableView.self),
                let indexPath = tableView.indexPath(for: cell)
                else { return }

            // Extract from frc the object at indexpath
            managedMCUMoviesObject = frc.object(at: indexPath) as? MCUMovies;

            destinationController.movieData = managedMCUMoviesObject
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData();
    }

}
