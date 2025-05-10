import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/news_bloc.dart';
import 'features/news/data/repository/news_repository.dart';
import 'features/news/presentation/screens/enable_notification_screen.dart';
import 'features/news/presentation/screens/enter_name_screen.dart';
import 'features/news/presentation/screens/news_feed_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsRepository(),
      child: BlocProvider(
        create: (context) => NewsBloc(context.read<NewsRepository>()),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: MaterialApp(
            title: 'FinHub',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            initialRoute: "/",
            routes: {
              "/" : (_) => EnterNameScreen(),
              "/enable-notification" : (_) => EnableNotificationScreen(),
              "/news-feed" : (_) => NewsFeedScreen()
            },
          ),
        ),
      ),
    );
  }
}
