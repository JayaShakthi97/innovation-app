import 'package:flutter/material.dart';
import 'package:innovation_flutter_app/bloc/categoryBloc.dart';
import 'package:innovation_flutter_app/bloc/chatBloc.dart';
import 'package:innovation_flutter_app/bloc/editTaskBloc.dart';
import 'package:innovation_flutter_app/bloc/taskBloc.dart';
import 'package:innovation_flutter_app/pages/splashScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditTaskBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            canvasColor: Colors.blue,
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0.0,
            )),
        home: SplashScreen(),
      ),
    );
  }
}
