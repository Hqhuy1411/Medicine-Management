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
              image != null ? Image.file(image!) : Text("No image selected"),
              if (image != null)
                ElevatedButton(
                  child: Text("send"),
                  onPressed: (() async {
                    try {
                      var request = http.MultipartRequest(
                          'POST', Uri.parse('http://192.168.1.18:8000/auth'));
                      var response = await request.send();
                      var responseBody = await response.stream.bytesToString();
                      var list = jsonDecode(responseBody);
                      // print(responseBody);
                      List<Medicine> medicines = [];
                      for (var i in list) {
                        var data = i as Map<String, dynamic>;
                        medicines.add(Medicine.fromJson(data));
                      }
                      // ignore: use_build_context_synchronously
                      final listReceive = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => App(
                                    list: medicines,
                                  )));
                      Navigator.pop(context, listReceive);
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
