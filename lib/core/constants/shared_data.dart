class SharedData {
  // TODO: Update this token with a valid token from login API
  // The current token may be expired. Get a new token by:
  // 1. Logging in through the app
  // 2. Or calling the login API and extracting the token from the response
  static String _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0Njk1YWVlOS1jMzNkLTQzNzMtOWRkYS0yODIyZTA3ODljOWEiLCJ1bmlxdWVfbmFtZSI6IisyMDEyMTA0MzU4NjUiLCJmaXJzdE5hbWUiOiJtdXN0YWZhIiwibGFzdE5hbWUiOiIiLCJhZGRyZXNzIjoiIiwiaW1nVXJsIjoiIiwiYmlydGhEYXRlIjoiMDAwMS0wMS0wMSIsImdlbmRlciI6Ik1hbGUiLCJsb2NhdGlvbiI6IiIsImlzTm90aWZpY2F0aW9uc0VuYWJsZWQiOiJUcnVlIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI0Njk1YWVlOS1jMzNkLTQzNzMtOWRkYS0yODIyZTA3ODljOWEiLCJleHAiOjE3NjMxMzIwNzAsImlzcyI6Imh0dHBzOi8vY3VyZS1kb2N0b3ItYm9va2luZy5ydW5hc3AubmV0LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDAsaHR0cHM6Ly9sb2NhbGhvc3Q6NTUwMCxodHRwczovL2xvY2FsaG9zdDo0MjAwICxodHRwczovL2N1cmUtZG9jdG9yLWJvb2tpbmcucnVuYXNwLm5ldC8ifQ.0oYRA8w5VWFsgSa_4fNm8buaeeFjqRS3oUZh5ibpcpg";
  
  static String get token => _token;
  
  static void setToken(String newToken) {
    _token = newToken;
  }
}