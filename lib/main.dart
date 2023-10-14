import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_riverpod/business_logic/cubit/movies_cubit.dart';
import 'package:provider_riverpod/data/repos/movies_repo.dart';
import 'package:provider_riverpod/data/webservises/movies_webservices.dart';
import 'package:provider_riverpod/platform_detection_package/platform_scroll.dart';
import 'package:provider_riverpod/presentation_layer/screens/movies_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MoviesWebService service = MoviesWebService();
  MoviesRepository repo = MoviesRepository(service);
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((value) => runApp(BlocProvider(
  //     create: (BuildContext context) => MoviesCubit(repo)..GetMovies(),
  //     child: const MyApp())));
  runApp(BlocProvider(
      create: (BuildContext context) => MoviesCubit(repo)..GetMovies(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'my app',
      theme: ThemeData.dark(),
      home: homePage(),
    );
  }
}

class homePage extends StatelessWidget {
  homePage({Key? key}) : super(key: key);

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MoviesScreen();
  }
}
