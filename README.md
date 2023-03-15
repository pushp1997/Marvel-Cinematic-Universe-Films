# Marvel Cinematic Universe (MCU) Movies App

This is an iPhone app that displays information about the Marvel Cinematic Universe (MCU) movies.
The app has four screens, each with a specific function.
The data for the movies is read from an XML file and managed by a model data class called Movie and a parser class called MoviesParser.

## Technical Details:
* Developed using Xcode 12.0
* Supports iOS 14 and above
* Written in Swift 5.3

## Screens:

### Screen 1 - UITableViewController:
* Displays a list of all the MCU movies, this UITableViewController uses a custom cell developed called CustomTableViewCell.
* Each cell appears like a card with shadows and rounded corners.
* Tapping on a movie takes the user to Screen 2

### Screen 2 - UIViewController:
* Displays the cover image of the selected movie
* Displays basic information about the movie such as release date, the saga it belongs to, and the phase it belongs to
* Contains a "More Details" button that takes the user to Screen 3

### Screen 3 - UIViewController:
* Displays complete information about the selected movie such as box office collection, duration, directed by, and number of post credits scenes
* Contains two buttons - "Watch Trailer" and "Read More on IMDB" - that take the user to Screen 4

### Screen 4 - UIWebView:
* Contains a WKWebView to display a webpage depending on the button pressed on Screen 3
* If "Watch Trailer" is pressed, it displays the trailer for the selected movie
* If "Read More on IMDB" is pressed, it displays the IMDB page for the selected movie

## Data Management:

* The Movie model data class represents information about each movie
* The MoviesParser parser class reads the data from an XML file in the app bundle and creates instances of the Movie class
* The parsed data is stored in an array for easy access by the rest of the app

## Future Improvements:

* Add search functionality to Screen 1 to allow users to quickly find a specific movie
* Use Core Data instead of an XML file for better data management and scalability

## References:

* Marvel Cinematic Universe (MCU) movies data xml has been taken from open source api - https://github.com/AugustoMarcelo/mcuapi
* Adding Shadows to Views: https://youtu.be/U-1Ub0jOi0s
* How to create custom cell for UITableViewController: https://youtu.be/mKzYqzT3f4Q
* Xcode - https://developer.apple.com/xcode/
* Swift - https://developer.apple.com/swift/
* WKWebView - https://developer.apple.com/documentation/webkit/wkwebview
* UITableViewController - https://developer.apple.com/documentation/uikit/uitableviewcontroller
* UIViewController - https://developer.apple.com/documentation/uikit/uiviewcontroller
