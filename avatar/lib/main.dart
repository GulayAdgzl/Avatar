
import 'package:avatar/features/camera/camera_screen.dart';
import 'package:avatar/features/splash/splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
// lib/main.dart
// Yenisi 
late List<CameraDescription> cameras;

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
 FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 await Permission.camera.request(); 
 
 cameras = await availableCameras();
 runApp(const MyApp());
}

class MyApp extends StatefulWidget {
 const MyApp({Key? key}) : super(key: key);

 @override
 State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 @override
 void initState() {
   super.initState();
   initialization();
 }

 void initialization() async {
   await Future.delayed(const Duration(seconds: 3));
   FlutterNativeSplash.remove();
 }

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Avatar Creator',
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: const SplashScreen(),
     routes: {
       '/camera': (context) => const CameraScreen(),
     },
   );
 }
}
