import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/image_analyzer/bloc/image_analyzer_bloc.dart';
import 'features/image_analyzer/view/image_analyzer_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageAnalyzerBloc>(create: (_) => ImageAnalyzerBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.grey[800],
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size(300, 60)),
              backgroundColor: MaterialStateProperty.all(Colors.grey[400]),
            ),
          ),
        ),
        home: const ImageAnalyzerView(),
      ),
    );
  }
}
