import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/service_locator.dart';
import 'core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app configuration (development by default)
  AppConfig.init(Environment.development);

  await setupServiceLocator();

  runApp(const JobMapApp());
}