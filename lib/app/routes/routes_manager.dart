import 'package:flutter/material.dart';

import '../../presentation/pages/calendar_page/calendar_page.dart';
import '../../presentation/pages/profile_page.dart';
import '../../presentation/pages/splash_page.dart';
import 'routes_names.dart';

class RoutesManager {
  static Route onGenerateRoute(settings) {
    switch (settings.name) {
      // [START] Splash Page
      // This is the first page that will be displayed when the app is opened
      // in this section we can add feature process before routing to the page
      case RoutesNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashPage());

      // [END] Splash Page

      // [START] Calendar Page

      case RoutesNames.calendar:
        return MaterialPageRoute(builder: (context) => const CalendarPage());

      // [END] Calendar Page

      // [START] Profile Page
      case RoutesNames.profile:
        return MaterialPageRoute(builder: (context) => const ProfilePage());

      // [END] Profile Page

      // [START] Default Page
      // This is the default page that will be displayed when the app is opened
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      // [END] Default Page
    }
  }
}
