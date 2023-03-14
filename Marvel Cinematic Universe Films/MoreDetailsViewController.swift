//
//  MoreDetailsViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit

class MoreDetailsViewController: UIViewController {
    
    var movieData: Movie!
    
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
        title = "Details: " + movieData.title
        
        releaseDateLabel.text = movieData.releaseDate
        phaseLabel.text = movieData.phase
        sagaLabel.text = movieData.saga
        boxOfficeLabel.text = movieData.boxOffice
        durationLabel.text = movieData.duration
        directedByLabel.text = movieData.directedBy
        postCreditScenesLabel.text = movieData.postCreditScenes
        overviewTextView.text = movieData.overview
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTrailer"{
            // Get the new view controller using segue.destination.
            let destinationController = segue.destination as! WebViewUIViewController
            
            // Pass the selected object to the new view controller.
            destinationController.link = movieData.trailerUrl
            destinationController.title = "Trailer: \(movieData.title)"
        }
        if segue.identifier == "toIMDB"{
            // Get the new view controller using segue.destination.
            let destinationController = segue.destination as! WebViewUIViewController
            
            // Pass the selected object to the new view controller.
            destinationController.link = URL(string: "https://www.imdb.com/title/\(movieData.imdbId)/")!
            destinationController.title = "IMDB: \(movieData.title)"
        }
    }

}
