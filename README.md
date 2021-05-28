# Sahara

## Project Description
Sahara is a web shop app created by Antonio Torres-Ruiz, Peter Gray and Justin Horner that allows users to browse a catalog and purchase products of their interests; this application also stores said items in a shopping cart, or a wishlist as the user sees fit. It also allows guests without an account to login as a temporary user with limited functionality.

## Features
* Create an Account with a user's name, phone number, email and password. Stored onto the phone in CoreData.
* Allows the user to choose whether they want to sign in via email or phone number.
* Displays messages that list the current user's information as input.
* 

## TODO
* Implement a manner to let user choose their own profile picture, cancel orders, list retail vs sales prices for each product.

## Getting Started
git clone https://github.com/atorresruiz8/Sahara
* Must be on MacOS and have Xcode installed.
* In Sahara folder, open the Sahara.xcodeproj project file.
* This app is primarily designed with the iPhone 11 in mind, so run the simulator using an iPhone 11 for the proper viewing experience.
* Build the project and run the app on a simulator, or iPhone.

## Usage
> Install the app onto either your simulator or iPhone by running the build command.
> Once the app is installed and running, wait for the splash screen to end.
> Create an account by selecting the "Create Account" button on the login screen, then entering a username and password.
> Create an admin account if it does not exist.
> If you wish, flip the switch to "On" after inputting your username and password on the login screen to save your information for next time. Sign in.
> If logged into admin role, the user can create a quiz by providing the category, type of question (typing or multiple choice), the question, answer and different answers to fill out the remaining slots of the question.
> The admin can also block a user from logging in by typing their username and submitting it.
> Admin can also view every users' scores by pushing a button.
> If the user is logged into a regular user role, they will be brought to a general dashboard screen.
> They can swipe on the screen, or push the menu button to present a side menu to go through the different screens related to specific users.
> Or they can push one of the four buttons in the middle of the screen to take a test.


## Contributors
* Antonio Torres-Ruiz, project leader, admin functionality designer, primarily set up and developed the CoreData functions, designed user functionality once logged in, and implemented Facebook integration.
* Peter Gray, primarily developed the dynamically created quizzes, including displaying said quizzes onto the screen. Also helped with UI design.
* Justin Horner, designed functionality to pass the user between the different screens of the app, along with helping calculate the rankings for each user based on scores and designed the user profile page.

## License

