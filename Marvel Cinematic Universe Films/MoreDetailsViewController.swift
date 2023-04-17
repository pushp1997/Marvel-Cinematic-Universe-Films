//
//  MoreDetailsViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit

class MoreDetailsViewController: UIViewController {
    
    var movieData: MCUMovies!
    
    // Outlets
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet weak var sagaLabel: UILabel!
    @IBOutlet weak var boxOfficeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var directedByLabel: UILabel!
    @IBOutlet weak var postCreditScenesLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Details: " + movieData.title!
        
        releaseDateLabel.text = movieData.releaseDate
        phaseLabel.text = String(movieData.phase)
        sagaLabel.text = movieData.saga
        boxOfficeLabel.text = String(movieData.boxOffice)
        durationLabel.text = String(movieData.duration)
        directedByLabel.text = movieData.directedBy
        postCreditScenesLabel.text = String(movieData.postCreditScenes)
        overviewTextView.text = movieData.overview

        // Styling the details ui view to look like a card
        overviewTextView.layer.cornerRadius = 10
        overviewTextView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        overviewTextView.layer.shadowOffset = CGSize(width: 1.75, height: 1.75)
        overviewTextView.layer.shadowRadius = 1.75
        overviewTextView.layer.shadowOpacity = 0.5
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTrailer"{
            // Get the new view controller using segue.destination.
            let destinationController = segue.destination as! WebViewUIViewController
            
            // Pass the selected object to the new view controller.
            destinationController.link = URL(string: movieData.trailerURL!)
            destinationController.title = "Trailer: \(String(describing: movieData.title!))"
        }
        if segue.identifier == "toIMDB"{
            // Get the new view controller using segue.destination.
            let destinationController = segue.destination as! WebViewUIViewController
            
            // Pass the selected object to the new view controller.
            let url = URL(string: "https://www.imdb.com/title/\(movieData.imdbID!)/")
            destinationController.link = url!
            destinationController.title = "IMDB: \(String(describing: movieData.title!))"
        }
    }

}
