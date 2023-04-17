//
//  UpdateMovieViewControllerViewController.swift
//  Marvel Cinematic Universe Films
//
//  Created by Pushp Vashisht on 16/04/2023.
//

import UIKit
import CoreData

class UpdateMovieViewControllerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var movieData: MCUMovies!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    var entity: NSEntityDescription!;
    var pickedImageData: Data!
    
    // MARK: - Outlets
    @IBOutlet weak var infoCollectionCard: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var boxOfficeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var directedByTextField: UITextField!
    @IBOutlet weak var phaseTextField: UITextField!
    @IBOutlet weak var sagaTextField: UITextField!
    @IBOutlet weak var chronologyTextField: UITextField!
    @IBOutlet weak var imdbIDTextField: UITextField!
    @IBOutlet weak var PostCreditSceneTextField: UITextField!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var trailerURLTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    
    // MARK: - Actions
    let imagepicker = UIImagePickerController()
    @IBAction func imagePickerButtonPressed(_ sender: Any) {
        imagepicker.sourceType = .savedPhotosAlbum
       imagepicker.allowsEditing = false
       imagepicker.delegate = self
       present(imagepicker,animated: true,completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]as! UIImage
        pickedImageData = image.jpegData(compressionQuality: 0)
        dismiss(animated: true)
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        if movieData == nil {
            entity = NSEntityDescription.entity(forEntityName: "MCUMovies", in: self.context);
            movieData = MCUMovies(entity: entity, insertInto: self.context);
            entity = NSEntityDescription.entity(forEntityName: "Favourites", in: self.context);
            let managedFavouritesObject = Favourites(entity: entity, insertInto: self.context);
            movieData.favourite = managedFavouritesObject
        }

        movieData.title = titleTextField.text
        movieData.releaseDate = releaseDateTextField.text
        movieData.boxOffice = Int64(boxOfficeTextField.text!)!
        movieData.duration = Int64(durationTextField.text!)!
        movieData.directedBy = directedByTextField.text
        movieData.phase = Int16(phaseTextField.text!)!
        movieData.saga = sagaTextField.text
        movieData.chronology = Int16(chronologyTextField.text!)!
        movieData.imdbID = imdbIDTextField.text
        movieData.postCreditScenes = Int16(PostCreditSceneTextField.text!)!
        movieData.trailerURL = trailerURLTextField.text
        movieData.overview = overviewTextView.text
        
        movieData.cover = pickedImageData
        
        do {
            try self.context.save()
        } catch {
            print("Could not update the data")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Add Movie"
        if movieData != nil {
            title = "Update: " + movieData.title!
            
            titleTextField.text = movieData.title
            releaseDateTextField.text = movieData.releaseDate
            boxOfficeTextField.text = String(movieData.boxOffice)
            durationTextField.text = String(movieData.duration)
            directedByTextField.text = movieData.directedBy
            phaseTextField.text = String(movieData.phase)
            sagaTextField.text = movieData.saga
            chronologyTextField.text = String(movieData.chronology)
            imdbIDTextField.text = movieData.imdbID
            PostCreditSceneTextField.text = String(movieData.postCreditScenes)
            trailerURLTextField.text = movieData.trailerURL
            overviewTextView.text = movieData.overview
        }

        // Styling the details ui view to look like a card
        infoCollectionCard.layer.cornerRadius = 10
        infoCollectionCard.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        infoCollectionCard.layer.shadowOffset = CGSize(width: 1.75, height: 1.75)
        infoCollectionCard.layer.shadowRadius = 1.75
        infoCollectionCard.layer.shadowOpacity = 0.5
    }

}
