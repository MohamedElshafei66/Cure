import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
<<<<<<< HEAD
      routerConfig:AppRoutes.router,
      debugShowCheckedModeBanner:false,

=======
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
>>>>>>> feat/home
    );
  }
}
