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
          backgroundColor: Color(0xff64abbf),
          title: Center(
            child: Text('SMART MEDICINE BOX',
            textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),) ,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
          padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
          // child: 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 320,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Color(0xff64abbf),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(top: 30, bottom: 40, left: 10, right: 10),
                  child: Stack(
                    children: [
                      // Positioned(
                        // top: 10,
                        // left: 60,
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                                // left: 100,
                              ),
                              Text(
                                'Select an Image from?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                                // left: 100,
                              ),
                              MaterialButton(
                                color: Colors.white,
                                child: const Text("Gallery",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff64abbf), fontWeight: FontWeight.bold)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                // padding: EdgeInsets.symmetric(horizontal: 120.0),
                                onPressed: () {
                                  pickImage();
                                }
                                ),
                              SizedBox(
                                height: 5,
                                // left: 100,
                              ),
                              MaterialButton(
                                color: Colors.white,
                                child: const Text("Camera",
                                    style: TextStyle(
                                        fontSize: 15, 
                                        color: Color(0xff64abbf), fontWeight: FontWeight.bold)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                // padding: EdgeInsets.symmetric(horizontal: 120.0),
                                onPressed: () {
                                  pickImageC();
                                }),
                            ],
                          ),
                          // child: Text(
                          //   'Select an Image from?',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 17.0,
                          //   ),
                          // ),
                        ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      //   // left: 100,
                      // ),
                      // Positioned(
                      //   // top: 35,
                      //   // left: 100,
                      //   child: Center(
                      //     child: MaterialButton(
                      //     color: Colors.white,
                      //     child: const Text("Gallery",
                      //         style: TextStyle(
                      //             fontSize: 15,
                      //             color: Color(0xff64abbf), fontWeight: FontWeight.bold)),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     // padding: EdgeInsets.symmetric(horizontal: 120.0),
                      //     onPressed: () {
                      //       pickImage();
                      //     }),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      //   // left: 100,
                      // ),
                      // Positioned(
                      //   top: 70,
                      //   left: 100,
                      //   child: Center(
                      //     child: MaterialButton(
                      //     color: Colors.white,
                      //     child: const Text("Camera",
                      //         style: TextStyle(
                      //             fontSize: 15, 
                      //             color: Color(0xff64abbf), fontWeight: FontWeight.bold)),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     // padding: EdgeInsets.symmetric(horizontal: 120.0),
                      //     onPressed: () {
                      //       pickImageC();
                      //     }),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              SizedBox(
                height: 30,
              ),
              image != null
                  ? ClipRect(
                      child: Align(
                          alignment: Alignment.center,
                          heightFactor: 0.7,
                          child: Image.file(image!)),
                    )
                  : Center(
                      child: Text(
                        'No image selected',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  // Text("No image selected"),
              if (image != null)
              Center(
                child: ElevatedButton(
                  // width: 10,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(bottom: 50),
                    fixedSize: Size(90, 40),
                    primary: Color(0xff64abbf),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // set độ bo góc của nút
                    ),
                  ),
                  child: Text("Next",
                   style: TextStyle(
                    color: Colors.white, // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  onPressed: (() async {
                    try {
                      // var request = http.MultipartRequest('POST',
                      //     Uri.parse('http://172.20.10.3:5000/upload-image'));
                      // request.files.add(await http.MultipartFile.fromPath(
                      //     'image', image!.path));

                      // final bytes = await image!.readAsBytes();
                      // final _imageBytes = bytes.buffer.asUint8List();
                      // final url = 'http://172.20.10.3:5000//upload-image';

                      // final response = await http.post(Uri.parse(url), body: {
                      //   'image': base64Encode(_imageBytes),
                      // });

                      final url = 'http://192.168.1.18:8000/auth';

                      final response = await http.post(Uri.parse(url));

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
                            content: Text("The image is not in the correct format!"),
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
              ),

                
            ],
          ),
        ));
  }
}
