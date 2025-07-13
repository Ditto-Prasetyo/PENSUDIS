import 'package:bintar_sepuh/pages/splashs/splashscreen_before_page.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // Only apply constraints if the app is running on desktop
  if (Platform.isWindows ||
      Platform.isLinux ||
      Platform.isMacOS ||
      Platform.isFuchsia) {
    setWindowTitle('Alumni Finder');
    var windowInfo = await getWindowInfo();
    var size = windowInfo.frame.size;
    setWindowMinSize(
        Size(size.width * 0.3125, size.height * 0.8333)); // Minimum window size
    setWindowMaxSize(
        Size(size.width * 1.5, size.height * 1.5)); // Maximum window size
  }
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PENSUDIS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(), debugShowCheckedModeBanner: false,
    );
  }
}