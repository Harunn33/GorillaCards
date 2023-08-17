class AppStrings {
  AppStrings._();
  // GENERAL
  static const appName = "Gorilla Cards";

  // base url
  static const String baseUrl = "https://stg-api.gorillacards.app/";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static const String signupPath = '/auth/signup';
  static const String signinPath = '/auth/signin';
  static const String createDeckPath = '/decks';

  static const String loadingPath = "assets/jsons/gorilla.json";

  static const String error = "Error";
  static const String success = "Success";
  static const String successRegistered = "You have successfully registered.";
  static const String invalidEmailOrPassword = "Email or password is wrong";
  static const String emailAlreadyExists = "Email already exists";

  // WELCOME
  static const welcomeTitle = "Welcome\nto Gorilla Cards";
  static const welcomeDescription =
      "Gorilla Cards is the new way to create, organize, and study flash cards. Its main functionality is based on Anki but with a modern touch.";
  static const welcomeDescription2 =
      "From our perspective, education and learning should be fun. In that viewpoint, we are creating modern version of flashcard apps with gamification elements. It's now in the kitchen and cooking...";
  // SIGN IN
  static const signin = "Sign In";
  static const signinTitle = "Welcome back Gorilla 🦍";
  static const dontHaveAccount = "Don't have an account ? ";
  // SIGN UP
  static const signup = "Sign Up";
  static const signupTitle = "Be a Gorilla 🦍";
  static const emailHint = "* Email";
  static const passwordHint = "* Password";
  static const passwordAgainHint = "* Password again";
  static const emailNotValid = "Email is not valid";
  static const emailBlankError = "Email cannot be blank";
  static const passwordBlankError = "Password cannot be blank";
  static const passwordNotValid = "Your password must be at least 6 characters";
  static const passwordAgainBlankError = "Password again cannot be blank";
  static const passwordAgainNotMatch = "Passwords do not match";
  static const hasAccount = "You already have an account ? ";

  // HOME
  static const noDecksYet = "There is no deck yet.";
  static const deckName = "Deck Name";
  static const deckDescription = "Description (Optional)";
  static const deckNameHint = "Enter your deck name";
  static const deckNameInvalid = "Deck name can not be empty";
  static const createDeckButtonTitle = "Create Deck";
  static const createdDeckSuccessMessage = "Deck created";
  static const createdDeckErrorMessage = "Deck does not created";
  static const delete = "Delete";
  static const edit = "Edit";
  static const addDeck = "Add Deck";
  static const browse = "Browse";
}
