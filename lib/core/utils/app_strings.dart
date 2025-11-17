abstract class AppStrings {
  //  Onboarding Screen
  static const String onboarding1Title = "Book Your Appointment Easily";
  static const String onboarding1Description =
      "Choose your preferred doctor, pick a suitable time, and confirm your visit in just a few taps. No calls, no waiting—just simple and fast booking.";

  static const String onboarding2Title = "Find Doctors Around You";
  static const String onboarding2Description =
      "Quickly discover trusted doctors near your area. Whether you need a general checkup or a specialist, we connect you with nearby clinics for fast and convenient care.";

  static const String next = "Next";
  static const String getStarted = "Get Started";
  static const String skip = "Skip";

  //  Sign In Screen
  static const String signInTitle = "Sign In";
  static const String enterPhoneNumber = "Enter your phone number";
  static const String enterYourNumber = "Enter your number";
  static const String signInWithPhone = "Sign in with your number";
  static const String signInWithGoogle = "Sign in with Google";
  static const String dontHaveAccount = "Don't have an account?";
  static const String signUp = " Sign up";
  static const String or = "or";

  //  Sign Up Screen
  static const String signUpTitle = "Create New Account";
  static const String fullName = "Full Name";
  static const String email = "Email";
  static const String phoneNumber = "Enter your number";
  static const String rememberMe = "Remember me";
  static const String signUpWithGoogle = "Sign up with Google";
  static const String alreadyHaveAccount = "Already have an account?";
  static const String signIn = " Sign in";

  //  OTP Verification Screen
  static const String otpTitle = "OTP Code Verification";
  static String otpDescription(String phoneNumber) {
    return "Code has been sent to $phoneNumber";
  }
  static const String resendCode = "Resend code in 55 s";
  static const String verify = "Verify";
  static const String wrongCode = "Wrong code";
  static const String resend = "Resend";
  static const String enterAnotherPhoneNumber = "Enter anther phone number";

  //  Home Screen
  static const String welcome = "Welcome back, Seif";
  static const String location = "129,El-Nasr Street, Cairo";
  static const String homeTitle = "Find Your Specialist";
  static const String searchHint = "Search for specialty, doctor";
  static const String categoriesTitle = "Specialties";
  static const String doctorsNearYou = "Doctors near you";
  static const String viewAll = "View all";

  //  Favorites
  static const String favoriteAppBar = "Your Favorite";
  static const String emptyFavoriteTitle = "Your favorite!";
  static const String emptyFavoriteDescription =
      "Add your favorite to find it easily";

  //  Notifications
  static const String notificationTitle = "Notifications";
  static const String emptyNotificationTitle = "Nothing to display here!";
  static const String emptyNotificationDescription =
      "We’ll notify you once we have new notifications.";
  static const String upcomingNotification =
      "Reminder: You have an appointment with...";
  static const String appointmentCompleted =
      "You have successfully booked your appointment with Dr. Emily Walker.";
  static const String appointmentConcelled =
      "You have successfully cancelled your appointment with Dr. David Patel.";
  static const String yourAppointment = "Your Appointment";

  //  Search
  static const String searchAppBar = "Search";
  static const String searchByLocation = "Search by your location";
  static const String allSpecialties = "All Specialties";
  static const String history = "History";

  //  Map
  static const String currentLocation = "Current location";
  static const String confirmLocation = "Confirm location";
  static const String yourLocation = "Your location";

  //  Doctor Details
  static const String doctorDetailsTitle = "Doctor Details";
  static const String doctorName = "Dr. Jessica Turner";
  static const String doctorSpeciality = "Pulmonologist";
  static const String doctorLocation = "129,El-Nasr Street, Cairo ";

  static const String patientsLabel = "patients";
  static const String experienceLabel = "experience";
  static const String ratingLabel = "rating";
  static const String reviewsLabel = "reviews";
  static const String addReview = "add review";

  static const String aboutMeTitle = "About me";
  static const String aboutMeDescription =
      "Dr. Jessica Turner, a board-certified Pulmonologist with 8 years of experience in diagnosing and treating a wide range of respiratory and breathing diseases.";

  static const String reviewsAndRatingTitle = "Reviews and Rating";
  static const String averageRatingLabel = "4.5/5";

  static const String reviewUserName = "Nahlia Reyna";
  static const String reviewText =
      "Excellent service! Dr. Jessica Turner was attentive and thorough. The clinic was clean, and the staff were friendly. Highly recommend for in-person care!";
  static const String reviewTime = "30 min ago";

  static const String priceLabel = "Price";
  static const String hourLabel = r"\hour";
  static const String priceValue = "350\$";

  static const String bookAppointment = "Book Appointment";
  static const String noBooking = "No bookings for this day";
  static const String cancelBooking = "Cancellation must be made at least 24 hours in advance to receive a refund";
  static const String areYouSure = "Are you sure?";
  static const String yesCancel = "Yes,cancel";

  //  Appointment

  static const String selectDay = "Select a day";
  static const String selectTime = "Select Time";
  static const String continuePay = "Continue to Pay";
  static const String pay = "Pay";
  static const String congratulations = "Congratulations!";
  static const String warning = "Warning!";
  static const String congratulationsDescription =
      "Your appointment with Dr. David Patel is confirmed for June 30, 2023, at 10:00 AM.";
  static const String done="Done";
  static const String editAppointment="Edit your appointment";
  static const String reschedule = "Reschedule";
  static const String booking = "My Booking";
  static const String cancel = "Cancel";
  static const String feedBack = "Feedback";
  static const String support = "Support";
  static const String bookAgain = "Book Again";
  static const String upComing = "Upcoming";
  static const String joinVideoCall = "Join Video Call";

  // Review
  static const String review = "Review";
  static const String yourRate = "Your Rate";
  static const String yourReview = "Your review";
  static const String writeYourReview = "Write your review";
  static const String sendYourReview = "Send your review";
  static const String thankForReview = "Thanks for your review";
  static const String backToHome = "Back to Home";

  //profile

  static const String profileTitle = "Profile";
  static const String notifications = "Notifications";
  static const String paymentMethod = "Payment Method";
  static const String settings = "Settings";
  static const String privacyPolicy = "Privacy Policy";
  static const String fAQs = "FAQs";


  static const String logout = "Logout";

  //  Edit Profile Screen
  static const String editProfileTitle = "Edit Profile";
  static const String emailAddress = "Email Address";
  static const String dateOfBirth = "Date of Birth";
  static const String gender = "Gender";
  static const String male = "Male";
  static const String female = "Female";
  static const String saveChangesButton = "Save Changes";

  //  Settings Screen
  static const String settingsTitle = "Settings";
  static const String changePassword = "Change Password";
  static const String notificationsSettings = "Notification Settings";

  //  Password Management Screen
  static const String passwordManagementTitle = "Password Management";
  static const String currentPassword = "Current Password";
  static const String newPassword = "New Password";
  static const String confirmNewPassword = "Confirm New Password";
  static const String changePasswordButton = "Change Password";

  //  Payment Method Screens
  static const String paymentMethodTitle = "Payment Method";
  static const String creditDebitCard = "Credit / Debit Card";
  static const String mobileWallet = "Mobile Wallet";
  static const String cach = "Cash";
  static const String creditCard = "Credit Cart";
  static const String applePay = "Apple Pay";

  //  Empty Cards Screen
  static const String emptyCardsTitle = "Payment Method";
  static const String emptyCardsMessage = "Nothing to display here!";
  static const String addYourCard ="Add your cards to make payment easier";
  static const String addNewCard = "Add new card";
  static const String addCardButton = "Add Card";

  //  Add New Card Screen
  static const String addNewCardTitle = "Add New Card";
  static const String cardHolderName = "Card Holder Name";
  static const String cardNumber = "Card Number";
  static const String expiryDate = "Expiry Date";
  static const String cvvCode = "CVV Code";
  static const String saveCardButton = "Save";

  // Chat List Screen
  static const String chatTitle = "Chat";
  static const String recentChats = "Recent";
  static const String favoritesChats = "Favorites";

  //  Search Chat Screen
  static const String searchChat = "Search for chat, doctor";
  static const String unreadTab = "Unread";
  static const String allTab = "All";

  //  Conversation / Message Screen
  static const String message = "Message";
  static const String unreadMessages = "Unread messages";

}
