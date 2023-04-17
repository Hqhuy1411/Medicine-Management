import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  Future<void> initializeCameraController() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _cameraController = CameraController(camera, ResolutionPreset.medium);
    await _cameraController.initialize();
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = initializeCameraController();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AspectRatio(
                  aspectRatio: 2 / 3,
                  child: CameraPreview(_cameraController),
                ),
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset(
                    'images/abc.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () => onTakePicture(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void onTakePicture() async {
    // await controller.takePicture().then((XFile xfile) {
    //   if (mounted) {
    //     if (xfile != null) {
    //       ref.read(xFileProvider.notifier).state = xfile;
    //       context.pushNamed(ProfileScreen.routeName);
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('Ambil Gambar'),
    //     content: SizedBox(
    //       width: 200.0,
    //       height: 200.0,
    //       child: CircleAvatar(
    //         backgroundImage: Image.file(
    //           File(xfile.path),
    //         ).image,
    //       ),
    //     ),
    //   ),
    // );
    //     }
    //   }
    //   return;
    // });
  }
}
