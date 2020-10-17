import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Seminario Sistemas',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File _cameraImage;
  File _cameraVideo;

  VideoPlayerController _cameraVideoPlayerController;
  
  // This funcion will helps you to pick and Image from Camera
  _pickImageFromCamera() async {
    // ignore: deprecated_member_use
    File image = await  ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      _cameraImage = image;    
    });
  }

   // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    // ignore: deprecated_member_use
    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
     _cameraVideo = video; 
    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
      setState(() { });
      _cameraVideoPlayerController.play();
      _cameraVideoPlayerController.setLooping(true);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APP FOTO Y VIDEO"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                if(_cameraImage != null)
                  Image.file(_cameraImage),
                  Padding(padding: const EdgeInsets.all(5.0)),
                  FloatingActionButton(
                    onPressed: () {
                      _pickImageFromCamera();
                    },
                    child: Icon(Icons.camera_alt),
                    backgroundColor: Colors.lightBlue[900],
                  ),
                Padding(padding: const EdgeInsets.all(5.0)),
                if(_cameraVideo != null) 
                      _cameraVideoPlayerController.value.initialized
                  ? AspectRatio(
                      aspectRatio: _cameraVideoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_cameraVideoPlayerController),
                    )
                  : Container(),
                  Padding(padding: const EdgeInsets.all(5.0)),
                  FloatingActionButton(
                    onPressed: () {
                      _pickVideoFromCamera();
                    },
                    child: Icon(Icons.videocam_rounded),
                    backgroundColor: Colors.red,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}