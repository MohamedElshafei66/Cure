import 'package:url_launcher/url_launcher.dart';

class GoogleMeetUtils {
  // Google Meet link constant
  static const String defaultMeetLink = 'https://meet.google.com/ujj-ekdk-obt';

  /// Opens a Google Meet link in the default browser or app
  /// 
  /// [meetLink] - The Google Meet URL to open. If not provided, uses the default link.
  /// Returns true if the URL was successfully launched, false otherwise.
  static Future<bool> openMeetLink([String? meetLink]) async {
    final String url = meetLink ?? defaultMeetLink;
    
    try {
      final Uri uri = Uri.parse(url);
      
      // Check if the URL can be launched
      if (await canLaunchUrl(uri)) {
        // Try to launch in external app first (Google Meet app if installed)
        final bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        
        if (!launched) {
          // Fallback to browser if app launch fails
          return await launchUrl(
            uri,
            mode: LaunchMode.externalNonBrowserApplication,
          );
        }
        
        return launched;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}


