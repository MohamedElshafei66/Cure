import 'package:flutter/material.dart';
import 'core/constants/dependincy_injection.dart';

import 'my_app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await DependincyInjection.init();

  runApp(const MyApp());
}
