import 'package:camera/camera.dart';
import 'package:fchat/Screens/camera_screen.dart';
import 'package:fchat/Screens/login_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "OpenSans",
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color(0xFF075E54),
              secondary: Color(0xFF128C7E),
            ),
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
