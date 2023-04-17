# Marvel Cinematic Universe (MCU) Movies App

This is an iPhone app that displays information about the Marvel Cinematic Universe (MCU) movies.
The app has five = screens, each with a specific function.
The data for the movies is read from Core Data which can initially be populated by XML file included in the package using a parser class called MoviesParser.
The Core Data has two entities MCUMovies (to store all the movies and their data) and Favourites (to add a movie to favourite or to like a movie), both the entities have a one to one relationship.

## Technical Details:
* Developed using Xcode 12.0
* Supports iOS 14 and above
* Written in Swift 5.3

## Screens:

### Screen 1 - UITableViewController:
* Displays a list of all the MCU movies, this UITableViewController uses a custom cell developed called CustomTableViewCell.
* Each cell appears like a card with shadows and rounded corners.
* Tapping on a movie takes the user to Screen 2
* Each cell has two buttons on it, the button with pencil icon (to be used to edit / update the movie details) and a button with heart icon (to be used to add a movie to favourites).
* Each cell can be swiped from right to left to perform delete operation on that particular movie.
* Initially, this view wont display any data as movies have not been added to the core data, so the user can either add the movie by clicking on the "+" icon at top right corner on the navigation controller or by pressing the reset button which is immediately left to the "+" button. The reset button parses the XML file and populates the data into Core Data.

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

### Screen 5 - UIViewController:
* These screen displayed when the user wants to add a new movie to the DB or when the user wants to edit / update an existing movie.
* Displays a for with various fields related to the movie data.
* When the user has completed the form, the save button can be pressed to save the desired changes to the DB.

## References:

* Marvel Cinematic Universe (MCU) movies data xml has been taken from open source api - https://github.com/AugustoMarcelo/mcuapi
* Adding Shadows to Views: https://youtu.be/U-1Ub0jOi0s
* How to create custom cell for UITableViewController: https://youtu.be/mKzYqzT3f4Q
* Xcode - https://developer.apple.com/xcode/
* Swift - https://developer.apple.com/swift/
* WKWebView - https://developer.apple.com/documentation/webkit/wkwebview
* UITableViewController - https://developer.apple.com/documentation/uikit/uitableviewcontroller
* UIViewController - https://developer.apple.com/documentation/uikit/uiviewcontroller
