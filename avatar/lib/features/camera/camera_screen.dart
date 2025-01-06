import 'package:avatar/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
 const CameraScreen({Key? key}) : super(key: key);

 @override
 State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
 late CameraController _controller;
 bool _isInitialized = false;
 
 @override
 void initState() {
   super.initState();
   _initCamera();
 }

 Future<void> _initCamera() async {
   final status = await Permission.camera.request();
   //.camera.request();
   if (status.isGranted) {
     try {
       _controller = CameraController(
         cameras[0],
         ResolutionPreset.medium,
         enableAudio: false,
         imageFormatGroup: ImageFormatGroup.jpeg
       );

       await _controller.initialize();
       setState(() => _isInitialized = true);

     } catch (e) {
       print('Camera error: $e');
     }
   }
 }

 Future<void> _switchCamera() async {
   try {
     final lensDirection = _controller.description.lensDirection;
     CameraDescription newCamera = cameras.firstWhere(
       (camera) => camera.lensDirection != lensDirection,
     );
     
     await _controller.dispose();
     
     _controller = CameraController(
       newCamera,
       ResolutionPreset.medium,
       enableAudio: false,
     );
     
     await _controller.initialize();
     setState(() {});
     
   } catch (e) {
     print('Switch camera error: $e');
   }
 }

 Future<void> _takePicture() async {
   try {
     final image = await _controller.takePicture();
     print('Picture saved: ${image.path}');
     
     // Fotoğrafı işleme için yönlendirme
     // Navigator.push(...);
     
   } catch (e) {
     print('Take picture error: $e');
   }
 }

 @override
 void dispose() {
   _controller.dispose();
   super.dispose();
 }

 @override
 Widget build(BuildContext context) {
   if (!_isInitialized) {
     return const Scaffold(
       backgroundColor: Colors.black,
       body: Center(
         child: CircularProgressIndicator(
           color: Colors.white,
         ),
       ),
     );
   }

   return Scaffold(
     backgroundColor: Colors.black,
     body: SafeArea(
       child: Stack(
         children: [
           CameraPreview(_controller),
           
           // Kontroller
           Positioned(
             bottom: 30,
             left: 0,
             right: 0,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 IconButton(
                   icon: const Icon(
                     Icons.flip_camera_ios,
                     color: Colors.white,
                     size: 28,
                   ),
                   onPressed: _switchCamera,
                 ),
                 GestureDetector(
                   onTap: _takePicture,
                   child: Container(
                     height: 80,
                     width: 80,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border: Border.all(
                         color: Colors.white,
                         width: 5,
                       ),
                     ),
                     child: Container(
                       margin: const EdgeInsets.all(5),
                       decoration: const BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                       ),
                     ),
                   ),
                 ),
                 IconButton(
                   icon: const Icon(
                     Icons.flash_on,
                     color: Colors.white, 
                     size: 28,
                   ),
                   onPressed: () async {
                     if (_controller.value.flashMode == FlashMode.off) {
                       await _controller.setFlashMode(FlashMode.torch);
                     } else {
                       await _controller.setFlashMode(FlashMode.off);
                     }
                     setState(() {});
                   },
                 ),
               ],
             ),
           ),
         ],
       ),
     ),
   );
 }
}