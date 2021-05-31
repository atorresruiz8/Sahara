# Sahara

## Project Description
Sahara is a web shop app created by Antonio Torres-Ruiz, Peter Gray and Justin Horner that allows users to browse a catalog and purchase products of their interests; this application also stores said items in a shopping cart, or a wishlist as the user sees fit. It also allows guests without an account to login as a temporary user with limited functionality.

## Features
* Create an Account with a user's name, phone number, email and password. Stored onto the phone in CoreData.
* Allows the user to choose whether they want to sign in via email or phone number.
* Displays messages that list the current user's information as input.
* Allows the user to search through the store via tags or direct string input, displaying them results should anything in the store match the user's search.
* A store featuring 30 dynamically programmed products within 5 departments for the user to choose from.
* Stores user's selected products in a cart or wishlist that the user has regular access to.
* Displays the user's latest 5 searches and can clear their entire search history.
* The user can ask for refunds from their purchased products to receive money in their Sahara online wallet.
* User can pay for their product with either cash on delivery, net banking, or credit/debit card.
* User can edit their shipping address, account information, or payment information at any time and have it instantly updated.
* Users can create temporary user accounts to browse the store and make a wishlist.
* Though temporary users cannot buy products, they can choose to upgrade and finish account creation to become a full fledged user and purchase goods from the store.

## TODO
* Implement a manner to let user choose their own profile picture, cancel orders, list retail vs sales prices for each product. Add the "Silk Road," a subscription feature for expediated shipping of products.

## Getting Started
git clone https://github.com/atorresruiz8/Sahara
* Must be on MacOS and have Xcode installed.
* In Sahara folder, open the Sahara.xcodeproj project file.
* This app is primarily designed with the iPhone 11 in mind, so run the simulator using an iPhone 11 for the proper viewing experience.
* Build the project and run the app on a simulator, or iPhone.

## Usage
> Install the app onto either your simulator or iPhone by running the build command.
> Once the app is installed and running, wait for the splash screen to end.
> Create an account by selecting the "Create Account" button on the login screen, then entering your name, phone number and/or email, and password.
> If you wish, flip the switch to "On" after inputting your email and/or phone number and password on the login screen to save your information for next time. Sign in.
> If the user chooses the "Browse" option, they will be logged in as a temporary user.
> This user cannot purchase products, but they can make a wishlist of products.
> Should the temporary user wish to become a permanent user, they have the option to.
> If the user is logged into a regular user role, they will be brought to a general dashboard screen.
> The user can flip between the tabs on the tab bar to view the Main Store, their Profile, their Cart, or quickly travel to the different departments' pages in the store.
> The user can search for products in the store to purchase, or they can view products recommended to them due to their previous search results, their wishlist, or their actual previous search result.
> The user can also see a daily deal on the main store page.
> The user can change their shipping information on the main store page or the cart page.


## Contributors
* Antonio Torres-Ruiz, project leader, primary UI designer, creator of the "Main" storyboard and classes under the "Dashboard" group. He is responsible for connecting all of the storyboards together.
* Peter Gray, creator of the "Account" storyboard and classes under the "Account" group. He is responsible for developing every class and functionality related to account creation and passing user information along between view controllers.
* Justin Horner, create of the "Payment" storyboard and classes under the "Payment" group. He is responsible for developing the pages used to display relevant information about the Products in the store.

## License

