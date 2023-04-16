//
//  MovieViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movieData: MCUMovies!
    
    // Outlets
    @IBOutlet weak var coverUIImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var phaseOutlet: UILabel!
    @IBOutlet weak var sagaOutlet: UILabel!
    @IBOutlet weak var detailsCard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = movieData.title
        
        // Populating data on the view
        coverUIImageView.image = UIImage(data: movieData.cover!)
        releaseDateLabel.text = movieData.releaseDate
        phaseOutlet.text = String(movieData.phase)
        sagaOutlet.text = movieData.saga
        
        // Styling the details ui view to look like a card
        detailsCard.layer.cornerRadius = 10
        detailsCard.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        detailsCard.layer.shadowOffset = CGSize(width: 1.75, height: 1.75)
        detailsCard.layer.shadowRadius = 1.75
        detailsCard.layer.shadowOpacity = 0.5
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            // Get the new view controller using segue.destination.
            let destinationController = segue.destination as! MoreDetailsViewController
            
            // Pass the selected object to the new view controller.
            destinationController.movieData = movieData
        }
    }

}
