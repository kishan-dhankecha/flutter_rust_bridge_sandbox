import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screens/main_screen.dart';
import 'package:my_app/src/rust/frb_generated.dart';

import 'blocs/image_bloc.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: false).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: BlocProvider(
        create: (context) => ImageBloc(),
        child: const MainScreen(),
      ),
    );
  }
}
