//
//  MovieViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 23/02/2023.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movieData: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = movieData.title
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
