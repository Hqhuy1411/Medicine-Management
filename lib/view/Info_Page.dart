import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../firebase_store/fire_base_auth.dart';
import '../model/Users.dart';
import 'Home_Page.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  var _firAuth = FirAuth();

  final email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments as Users;
    TextEditingController nameController =
        TextEditingController(text: info.name);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController phoneController =
        TextEditingController(text: info.phone.toString());
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Edit Profile'),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
        // padding: const EdgeInsets.all(16.0),
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 340,
              height: 50,
              color: Color(0xff64abbf),
              margin: EdgeInsets.only(top: 30, bottom: 40, left: 20, right: 20),
              child: Stack(
                children: [
                  // Positioned(
                  //   top: 5, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                  //   left: 5, // set vị trí đứng từ phải qua, dựa vào giá trị x
                  //   child: IconButton(
                  //     icon: Icon(
                  //             Icons.arrow_back_outlined,
                  //             color: Color(0xFFFFFFFF),
                  //           ),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const DashBoardPage()));
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(builder: (context) => DashBoardPage()),
                  //       // );
                  //       // Navigator.pop(context);
                  //     },
                  //   ),
                  // ),
                  Positioned(
                    // top: 30, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                    // left: 0, // set vị trí đứng từ trái qua, dựa vào giá trị x
                    // right: 0,
                    child: Center(
                      child: Text(
                        'SMART MEDICINE BOX',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Name:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: nameController,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Phone:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: phoneController,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Email:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(controller: emailController, enabled: false),
            SizedBox(
              height: 32,
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 0, left: 90, right: 90),
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff64abbf), // set màu sắc của nút
                  // onPrimary: Colors.white, // set màu sắc của chữ
                  // padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 70.0), // set kích thước của nút
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // set độ bo góc của nút
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white, // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  // Save changes to user's profile
                  _firAuth.updateUser(
                      nameController.text, phoneController.text, info.uid);
                  info.name = nameController.text;
                  info.phone = int.parse(phoneController.text);
                  Navigator.pushNamed(context, HomePage.routeName,
                      arguments: info);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
