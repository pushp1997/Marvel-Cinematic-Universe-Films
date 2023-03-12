//
//  MovieViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movieData: Movie!
    
    // Outlets
    @IBOutlet weak var coverUIImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var phaseOutlet: UILabel!
    @IBOutlet weak var sagaOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = movieData.title
        
        coverUIImageView.image = UIImage(named: movieData.cover)
        releaseDateLabel.text = movieData.releaseDate
        phaseOutlet.text = movieData.phase
        sagaOutlet.text = movieData.saga
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
