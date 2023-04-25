import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/Medicine.dart';
import 'package:http/http.dart' as http;

import '../abc.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage();
                  }),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImageC();
                  }),
              SizedBox(
                height: 20,
              ),
              image != null
                  ? ClipRect(
                      child: Align(
                          alignment: Alignment.center,
                          heightFactor: 0.7,
                          child: Image.file(image!)),
                    )
                  : Text("No image selected"),
              if (image != null)
                ElevatedButton(
                  child: Text("send"),
                  onPressed: (() async {
                    try {
                      // var request = http.MultipartRequest('POST',
                      //     Uri.parse('http://172.20.10.3:5000/upload-image'));
                      // request.files.add(await http.MultipartFile.fromPath(
                      //     'image', image!.path));

                      final bytes = await image!.readAsBytes();
                      final _imageBytes = bytes.buffer.asUint8List();
                      final url = 'http://172.20.10.3:5000//upload-image';

                      final response = await http.post(Uri.parse(url), body: {
                        'image': base64Encode(_imageBytes),
                      });

                      // final url = 'http://192.168.1.102:8000/auth';

                      // final response = await http.post(Uri.parse(url));

                      if (response.statusCode == 200) {
                        print('Upload success!');
                        var list = json.decode(response.body);
                        List<Medicine> medicines = [];
                        for (var i in list) {
                          var data = i as Map<String, dynamic>;
                          medicines.add(Medicine.fromJson(data));
                        }
                        if (medicines.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Anh khong dung format"),
                          ));

                          return;
                        }
                        // ignore: use_build_context_synchronously
                        final listReceive = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => App(
                                      list: medicines,
                                    )));
                        Navigator.pop(context, listReceive);
                      } else {
                        print(
                            'Upload failed. Error code: ${response.statusCode}');
                      }
                      // var response = await request.send();
                      // var responseBody = await response.stream.bytesToString();
                      // var list = jsonDecode(responseBody);
                      // // print(responseBody);
                      // List<Medicine> medicines = [];
                      // for (var i in list) {
                      //   var data = i as Map<String, dynamic>;
                      //   medicines.add(Medicine.fromJson(data));
                      // }
                      // // ignore: use_build_context_synchronously
                      // final listReceive = await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => App(
                      //               list: medicines,
                      //             )));
                      // Navigator.pop(context, listReceive);
                    } catch (err) {
                      print(err);
                    }
                  }),
                )
            ],
          ),
        ));
  }
}
