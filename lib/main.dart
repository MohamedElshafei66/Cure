import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

 
  final authProvider = AuthProvider();
  await authProvider.loadTokens();

  runApp(
    ChangeNotifierProvider(
      create: (_) => authProvider,
      child: const MyApp(),
    ),
  );
}
