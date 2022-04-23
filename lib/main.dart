import 'package:flutter/material.dart';
import 'package:login_to_do_list_app/src/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List App',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
      },
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Colors.deepPurple,
            ),
      ),
    );
  }
}
