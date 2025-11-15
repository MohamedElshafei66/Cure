class ApiEndpoints {
  static const String register = "Identity/Accounts/Register";
  static const String verifyRegister = "Identity/Accounts/verify-register";
  static const String verifyLogin = "Identity/Accounts/verify-login";
  static const String googleLogin = "Identity/Accounts/google-login";
  static const String resendOtp = "Identity/Accounts/resend-otp";
  static const String login = "Identity/Accounts/login";
  static const String refreshToken = "Identity/Accounts/refresh-token";
  static const String logout = "Identity/Accounts/logout";
  static const String getUserNotifications =
      "Customer/Notifications/GetNotificationsByUser";
  static const String putMarkAsRead = "Customer/Notifications/MarkAsRead/";
  static const String chatsList = "chat/chat/chats";
  static const String startChat = "chat/chat/startChat?receiverId=doc-user-2";
  static const String searchChat = "chat/chat/chats?search=John";
  static const String chatsUnread = "chat/chat/chats?isUnRead=true";
  static const String sendChat = "chat/chat/send";
  static const String favouriteChat = "chat/chat/chats?isfavoutire=true";
  static const String markChatAsFavourite = "chat/chat/chatfavourite";
}
