import 'package:favorite_app_using_bloc_state_managment/favorite-app_ui/favorite_home_screen.dart';
import 'package:favorite_app_using_bloc_state_managment/favorite_app_state/favorite_app_bloc.dart';
import 'package:favorite_app_using_bloc_state_managment/repository/favorite_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteAppBloc(FavouriteRepository()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark, // Use dark mode
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark, // ✅ Correct brightness
          ),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

