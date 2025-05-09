import 'package:fin_hub/features/news/presentation/screens/enable_notification_screen.dart';
import 'package:fin_hub/features/news/presentation/screens/enter_name_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      routes: {
        "/" : (_) => EnterNameScreen(),
        "/enable-notification" : (_) => EnableNotificationScreen(),
        "/news-feed" : (_) => EnterNameScreen()
      },
    );
  }
}
